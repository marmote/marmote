configuration CsmaTxAppC
{
}

implementation
{
    components MainC;
    components CsmaTxC as App;
    components LedsC;
    components new TimerMilliC();

    components ActiveMessageC;
    components new AMSenderC(0x66);

    App.Boot -> MainC.Boot;
    App.Leds -> LedsC;
    App.MilliTimer -> TimerMilliC;
    App.AMControl -> ActiveMessageC;
    App.AMSend -> AMSenderC;
    App.Packet -> AMSenderC;
}


