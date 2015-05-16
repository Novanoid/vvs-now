from vvs_now_django.celery import app
import requests
from user.models import User, AppleDeviceToken
from apns import APNs, Frame, Payload
from datetime import datetime, timedelta

@app.task
def calculate_route(task):
    gps = AppleDeviceToken.objects.filter(user=task.user).order_by('-gps__last_update')[0].gps
    dt_time = datetime.utcnow().replace(tzinfo=None)-timedelta(hours=1)
    test = gps.last_update.replace(tzinfo=None)
    if test < dt_time:
        pass # silent push
    url = "http://efastatic.vvs.de/OpenVVSDay/XML_TRIP_REQUEST2?locationServerActive=1&type_origin=coord&name_origin={}:{}:WGS84&type_destination=any&name_destination={}&itdDate={}&itdTime={}&itdTripDateTimeDepArr=arr&outputFormat=JSON&coordOutputFormat=WGS84[DD.ddddd]"
    destination_id = task.destination
    lat = 9.16990281007032
    long = 48.7201044436987

    date = task.time.date()
    date = str(date).replace("-", "")
    time = str(task.time.time())[:5]
    url = url.format(lat, long, destination_id, date, time)
    response = requests.get(url)
    if response.status_code == 200:
        response = response.json()

        trips = response.get("trips")
        #for trip in trips:
        trip = trips[0]
        start_time = trip.get("legs")[1].get("points")[0].get("dateTime").get("rtTime")
        next_stop = trip.get("legs")[1].get("points")[0].get("nameWithPlace")
        destination = trip.get("legs")[-1].get("points")[-1].get("nameWithPlace")
        line = trip.get("legs")[1].get("mode").get("name")
        direction = trip.get("legs")[1].get("mode").get("destination")
        platform = trip.get("legs")[1].get("points")[0].get("ref").get("platform")
        text = "Route nach {}\nJetzt zur Haltestelle {} losgehen, um die {} in Richtung {} um {} an Gleis {} zu erreichen."

        message = text.format(destination, next_stop, line, direction, start_time, platform)
        print(message)
        delays = None
        notify_user(User.objects.get(pk=1), message)
    else:
        pass
        # TODO schedule again

def notify_user(user, message):
    apns = APNs(use_sandbox=True, cert_file='pushcert.pem', key_file='pushcert.pem')
    for token in AppleDeviceToken.objects.filter(user=user):
    # Send a notification to every device
        token_hex = token.token
        payload = Payload(alert=message, sound="default", badge=1)
        apns.gateway_server.send_notification(token_hex, payload)
