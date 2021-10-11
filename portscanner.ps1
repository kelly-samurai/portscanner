#cls # Clear the screen

# Putting all arguments to the respective variable
$device = $args[0]
$port = $args[1]
$start = $args[2]
$stop = $args[3]

#funtion pingedevice
#ping a device to see if it's on the network
function ping_device
{
    if (test-connection $device -erroraction SilentlyContinue)
    {
        Write-Output "[+] $device is Up!"      
    }
    else
    {
        Write-Output "[-] $device is Down!"
        exit
    }
}

#function checkports
#checkl to see if our ports are open
function check_ports
{
    if ($port -match "multi")
    { #this range checks a port range
      for ($counter = $start; $counter -le $stop; $counter++)
        {
          Write-Output "[*] Testing port $counter on $device"
          $porttest = new-object Net.Sockets.TcpClient
            try
            {
              $connect = $porttest.connect($device, $counter)
              Write-Output "[+] Port $counter is open"
            }
            catch
            {
              Write-Output "[-] Port $counter is closed"
            }      
        }
    }
    else
    { #this brach cheks a single port
        Write-Output "[*] Testing port $port on $device"
        $porttest = new-object Net.Sockets.TcpClient
        try
        {
            $connect = $porttest.connect($device, $port)
            Write-Output "[+] Port $port is open"
        }catch{
            Write-Output "[-] Port $port is closed"
        }
    }
}

#run our functions
ping_device
check_ports