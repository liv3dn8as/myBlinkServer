-- Put together by liv3dn8as, Created April 2017
-- Needed Modules: enduser_setup, file, GPIO, net, node, timer, UART, WiFi

-- Attempt to use enduser_setup instead of hardcoding in credentials
enduser_setup.start(
   function()
      print("Connected to wifi as:" .. wifi.sta.getip())
   end,
   function(err, str)
      print("enduser_setup: Err #" .. err .. ": " .. str)
   end,
   print -- Lua print function can server as the debug callback
);
