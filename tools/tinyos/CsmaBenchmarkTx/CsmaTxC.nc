typedef nx_struct radio_count_msg {
  nx_uint16_t counter;
} radio_count_msg_t;

module CsmaTxC
{
    uses
    {
        interface Leds;
        interface Boot;
        interface Timer<TMilli> as MilliTimer;
        interface AMSend;
        interface SplitControl as AMControl;
        interface Packet;
    }
}

implementation
{
    message_t packet;
    bool busy;

    radio_count_msg_t* payload;
    uint8_t ctr;

    event void Boot.booted()
    {
        call AMControl.start();
    }

    event void MilliTimer.fired()
    {
        if (busy)
        {
            return;
        }
        else if (call AMSend.send(AM_BROADCAST_ADDR, &packet, sizeof(radio_count_msg_t)) == SUCCESS)
        {
            call Leds.led2On();
            payload = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
            payload->counter = ctr++;
            busy = TRUE;
        }
    }

    event void AMSend.sendDone(message_t* bufPtr, error_t error)
    {
        busy = FALSE;
        call Leds.led2Off();
    }

    event void AMControl.startDone(error_t err)
    {
        call MilliTimer.startPeriodic(200);
    }

    event void AMControl.stopDone(error_t err)
    {

    }
}