/**
 * Example program which shows how to get WiiRemote Accelrometer information
 *
 * Requres the following Arduino libraries
 *
 * WiiRemote - http://sudarmuthu.com/arduino/wiiremote
 * USB Host Shield Library - https://github.com/felis/USB_Host_Shield
 */

/**
 * Copyright 2011  Sudar Muthu  (email : sudar@sudarmuthu.com)
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <sudar@sudarmuthu.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer or coffee in return - Sudar
 * ----------------------------------------------------------------------------
 */

#include <Usb.h>
#include <WiiRemote.h>

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

// Call back which is executed by wiiremote.task() method
void myapp(void) {
    double x, y, z;

    x = wiiremote.Report.Accel.X;
    y = wiiremote.Report.Accel.Y;
    z = wiiremote.Report.Accel.Z;

    Serial.print(x);
    Serial.print(", ");
    Serial.print(y);
    Serial.print(", ");
    Serial.print(z);

    if (x < 0 && x > -1) {
        Serial.print("Left, ");
    }

    if (x > 0 && x < 1) {
        Serial.print("Right, ");
    }

    if (y > 0 && y < 1) {
        Serial.print("Up, ");
    }

    if (y < 0 && y > -1) {
        Serial.print("Down, ");
    }

    if (z > 0) {
        Serial.print("Facing Up, ");
    }

    if (z < 0) {
        Serial.print("Facing Down, ");
    }

    Serial.println();
}
// vim: sts=2 sw=2 ts=2 et cin
