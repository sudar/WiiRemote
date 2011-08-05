/**
 * Example program which shows how to get the streeing angle to control a bot using WiiRemote
 *
 * Requres the following Arduino libraries
 *
 * WiiRemote -
 * USB Host Shield Library - https://github.com/felis/USB_Host_Shield
 */

#include <Usb.h>
#include <WiiRemote.h>

#define STEERING_ANGLE_MAX    165
#define STEERING_ANGLE_MIN    15
#define STEERING_ANGLE_CENTER 90
#define STEERING_ANGLE_STEP   5

WiiRemote wiiremote;

void setup() {
    Serial.begin(9600);
    wiiremote.init();

    // This is the bluetooth address of your Wii remote. You need to find it and change here
    uint8_t wiiremote_bdaddr[6] = {0x00, 0x24, 0x1e, 0x7e, 0x93, 0x3e};
    wiiremote.setBDAddress(wiiremote_bdaddr, 6);
    wiiremote.setBDAddressMode(BD_ADDR_FIXED);
}

void loop() {
    wiiremote.task(&myapp);
    if (!(wiiremote.getStatus() & WIIREMOTE_STATE_RUNNING)) {
        Serial.print("\r\nlost Bluetooth connection");
    }
}

void myapp(void) {
    int steering_angle = getSteeringAngle();
    // Move your bot using this angle
}

int getSteeringAngle(void) {
    double rad;
    double deg;

    rad = acos((double) wiiremote.Report.Accel.Y);
    deg = rad * 180.0 / PI;

    /* clipping */
    if (deg > STEERING_ANGLE_MAX) {
        deg = STEERING_ANGLE_MAX;
    }
    if (deg < STEERING_ANGLE_MIN) {
        deg = STEERING_ANGLE_MIN;
    }

    Serial.print("\r\nSteering angle = ");
    Serial.print((int) deg);

    return (int) deg;
}


// vim: sts=2 sw=2 ts=2 et cin
