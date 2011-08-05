/**
 * Example program which shows how to make WiiRemote talk to Arduino with a USB Host Shield
 *
 * Requres the following Arduino libraries
 *
 * WiiRemote -
 * USB Host Shield Library - https://github.com/felis/USB_Host_Shield
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
        //Serial.print("\r\nlost Bluetooth connection");
    }
}

// Call back which is executed by wiiremote.task() method
void myapp(void) {

//    wiiremote.setLED(0x0); // Turn all LED On

    if (wiiremote.buttonClicked(WIIREMOTE_LEFT)) {
        Serial.println("Left Button clicked");
        wiiremote.setLED(0x10); // Turn First LED On
    }

    if (wiiremote.buttonClicked(WIIREMOTE_RIGHT)) {
        Serial.println("Right Button clicked");
        wiiremote.setLED(0x80); // Turn Fourth LED On
    }

    if (wiiremote.buttonClicked(WIIREMOTE_DOWN)) {
        Serial.println("Down Button clicked");
        wiiremote.setLED(0x40); // Turn Third LED On
    }

    if (wiiremote.buttonClicked(WIIREMOTE_UP)) {
        Serial.println("Up Button clicked");
        wiiremote.setLED(0x20); // Turn Second LED On
    }

    if (wiiremote.buttonClicked(WIIREMOTE_PLUS)) {
        Serial.println("Plus Button clicked");
    }

    if (wiiremote.buttonClicked(WIIREMOTE_TWO)) {
        Serial.println("Button Two clicked");
    }

    if (wiiremote.buttonClicked(WIIREMOTE_ONE)) {
        Serial.println("Button One clicked");
    }

    if (wiiremote.buttonClicked(WIIREMOTE_B)) {
        Serial.println("Button B clicked");
    }

    if (wiiremote.buttonClicked(WIIREMOTE_A)) {
        Serial.println("Button A clicked");
    }

    if (wiiremote.buttonClicked(WIIREMOTE_MINUS)) {
        Serial.println("Minus Button clicked");
    }

    if (wiiremote.buttonClicked(WIIREMOTE_HOME)) {
        Serial.println("Home Button clicked");
        wiiremote.setLED(0xf0); // Turn Off all LED
    }
}
// vim: sts=2 sw=2 ts=2 et cin
