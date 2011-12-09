hudpr = dsp.UDPReceiver;
hudps = dsp.UDPSender;

bytesSent = 0;
bytesReceived = 0;
dataLength = 128;

for k = 1:20
   dataSent = uint8(255*rand(1,dataLength));
   bytesSent = bytesSent + dataLength;
   step(hudps, dataSent);
   dataReceived = step(hudpr);
   bytesReceived = bytesReceived + length(dataReceived);
end

release(hudps);
release(hudpr);

fprintf('Bytes sent:     %d\n', bytesSent);
fprintf('Bytes received: %d\n', bytesReceived);