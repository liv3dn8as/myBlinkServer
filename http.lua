-- Put together by liv3dn8as, Created April 2017
-- Needed Modules: enduser_setup, file, GPIO, net, node, timer, UART, WiFi

led2 = 4 -- GPIO2 on ESP-01
gpio.mode(led2, gpio.OUTPUT)
hname="myESP8266-3"

enduser_setup.stop()

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
--net.server:listen(80,function(conn)
   conn:on("receive", function(client,request)
      local buf = "";
      local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+)HTTP");
      if(method == nil)then
         _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
      end
      local _GET = {}
      if (vars ~= nil)then
         for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do 
            _GET[k] = v
         end
      end
   
      buf = buf.."<h1>"..wifi.sta.gethostname().."'s Web Server</h1><form src=\"/\">Turn GPIO2 <select name=\"pin\" onchange=\"form.submit()\">"
      local _on,_off = "",""
      if(_GET.pin == "ON")then
         _on = " selected=true"
         gpio.write(led2, gpio.HIGH)
      elseif(_GET.pin == "OFF")then
         _off = " selected=\"true\""
         gpio.write(led2, gpio.LOW)
      end
         buf = buf.."<option".._on..">ON</opton><option".._off..">OFF</option></select></form>"
      client:send(buf);
      collectgarbage();
   end)
   conn:on("sent", function (c) c:close() end)
end)
