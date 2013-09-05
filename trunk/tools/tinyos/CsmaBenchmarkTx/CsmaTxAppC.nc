configuration CsmaTxAppC
{
}

implementation
{
    components CsmaTxC as App;
    components MainC;
    components LedsC;
    components new Alarm32khz32C() as AlarmC;
    components CC2420ActiveMessageC as MessageC;
    components RandomC;

    App.Boot -> MainC.Boot;
    App.Leds -> LedsC;
    App.Alarm -> AlarmC;
    App.AMControl -> MessageC;
    App.AMSend -> MessageC.AMSend[0x66];
    App.Packet -> MessageC.Packet;
    App.RadioBackoff -> MessageC.RadioBackoff;
    //App.RadioBackoff -> MessageC.RadioBackoff[0x66];
    App.Random -> RandomC;
}


