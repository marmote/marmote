//#include "Timer.h"

#ifndef AVG_INT
    #define AVG_INT 100
    #warning "AVG INT undefined, using default value 100"
#endif
#ifndef STD_INT
    #define STD_INT 20
    #warning "STD INT VAR undefined, using default value 20"
#endif

typedef nx_struct radio_count_msg {
  nx_uint16_t counter;
} radio_count_msg_t;

module CsmaTxC
{
    uses
    {
        interface Leds;
        interface Boot;
        interface Alarm<T32khz, uint32_t> as Alarm;
        interface AMSend;
        //interface RadioBackoff;
        interface RadioBackoff[am_id_t amId];
        interface SplitControl as AMControl;
        interface Packet;
        interface Random;
    }
}

implementation
{
    enum { D32KHZ_TO_MILLI = 33 };

    uint32_t interval_base = AVG_INT;
    norace uint32_t interval_mask;
    uint32_t interval_next;

    message_t packet;
    bool busy;

    radio_count_msg_t* payload;
    uint16_t ctr;

    task void sendPacketTask()
    {
        if (busy)
        {
            call Leds.led1On();
            return;
        }
        else
        {
            if (call AMSend.send(AM_BROADCAST_ADDR, &packet, sizeof(radio_count_msg_t)) == SUCCESS)
            {
                payload = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
                payload->counter = ctr++;
                busy = TRUE;
            }
        }
    }

    void initIntervalMask()
    {
        uint32_t z = 0;
        while ((uint32_t)AVG_INT * STD_INT / 100 > (uint32_t)((1 << (z+1)) - 1))
        {
            z++;
        }
        interval_mask = (1 << (z + 5)) - 1;
    }

    event void Boot.booted()
    {
        //call AMControl.start();
    }

    event void AMControl.startDone(error_t err)
    {
        initIntervalMask();
//        call Alarm.start(AVG_INT * D32KHZ_TO_MILLI);
        call Alarm.start(interval_base * D32KHZ_TO_MILLI);
    }

    event void AMControl.stopDone(error_t err)
    {

    }

    async event void Alarm.fired()
    {
        uint32_t rnd;
        call Leds.led2On();
        // FIXME: move this calculation to a task
        atomic
        {
//            call Alarm.start(AVG_INT * D32KHZ_TO_MILLI);
            interval_next = interval_base * D32KHZ_TO_MILLI;
            rnd = call Random.rand32();
            if (rnd & 0x80000000)
            {
                interval_next += rnd & interval_mask;
            }
            else
            {
                interval_next -= rnd & interval_mask;
            }
            call Alarm.start(interval_next);
        }
        post sendPacketTask();
    }

    event void AMSend.sendDone(message_t* bufPtr, error_t error)
    {
        busy = FALSE;
        call Leds.led2Off();
    }

    async event void RadioBackoff.requestInitialBackoff[am_id_t id](message_t *msg)
    {

    }

    async event void RadioBackoff.requestCongestionBackoff[am_id_t id](message_t *msg)
    {

    }

    async event void RadioBackoff.requestCca[am_id_t id](message_t *msg)
    {

    }

}
