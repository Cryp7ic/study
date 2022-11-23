# Viewing Linux Logs from the Command Line

sudo journalctl -p 3 -xb

At some point in your career as a Linux administrator, you are going to  have to view log files. After all, they are there for one very important reason…to help you troubleshoot an issue. In fact, every seasoned  administrator will immediately tell you that the first thing to be done, when a problem arises, is to view the logs.  

And there are plenty of logs to be found: logs for the system, logs  for the kernel, for package managers, for Xorg, for the boot process,  for Apache, for MySQL… For nearly anything you can think of, there is a log file.  

Most log files can be found in one convenient location: */var/log*. These are all system and service logs, those which you will lean on  heavily when there is an issue with your operating system or one of the  major services. For desktop app-specific issues, log files will be  written to different locations (e.g., Thunderbird writes crash reports  to ‘~/.thunderbird/Crash Reports’). Where a desktop application will  write logs will depend upon the developer and if the app allows for  custom log configuration.  

We are going to be focus on system logs, as that is where the heart  of Linux troubleshooting lies. And the key issue here is, how do you view those log files?  Fortunately there are numerous ways in which you can view your system logs, all quite simply executed from the command line.

## What’s Syslog?

Syslog is a standard for creating and transmitting logs. The word “syslog” can refer to any of the following:

1. The syslog service receives and processes syslog messages and listens for events by creating a socket located at `/dev/log`, which applications can write to. It can write messages to a local file  or forward messages to a remote server. There are different syslog  implementations, including [rsyslogd](https://www.rsyslog.com/) and [syslog-ng](https://www.syslog-ng.com/).
2. The Syslog protocol ([RFC 5424](https://tools.ietf.org/html/rfc5424)) is a transport protocol specifying how to transmit logs over a network. It’s also a data format defining how messages are structured. By  default, it uses port 514 for plaintext messages and port 6514 for  encrypted messages.
3. A syslog message is any log formatted in the [syslog message format](https://tools.ietf.org/html/rfc5424#section-6) and consists of a standardized header and message containing the log’s contents.

Since Syslog can forward messages to remote servers, it’s often used to forward system logs to log management solutions such as [SolarWinds® Loggly®](https://www.loggly.com/) and [SolarWinds Papertrail™](https://www.solarwinds.com/papertrail).

### RFC 3164 vs. RFC 5424

While RFC 5424 is the current Syslog protocol, it’s not the only  standard you’ll see in the wild. RFC 3164 (a.k.a. “BSD syslog” or “old  syslog”) is an older syslog format still used by many devices. In  practice, admins are likely to see syslog messages that use both RFC  3164 and RFC 5424 formatting.

Good indicators of an RFC 3164 syslog message are the absence of  structured data and timestamps using an “Mmm dd hh:mm:ss” format.

Here are some examples of what BSD messages look like, using [section 5.4 of RFC 3164](https://datatracker.ietf.org/doc/html/rfc3164#section-5.4) as a reference:

```
<34>Nov 11 11:11:11 pepeggserver su: 'su admin' failed **for** user1 **on** /dev/**pts**/0
<13>**Nov** 11 11:11:11 198.51.100.11 **Read** **the** **docs**!
```

We’ll focus on the newer RFC 5424 protocol here, but keep RFC 3164 in mind if you see messages that don’t conform to RFC 5424.

## Syslog Format and Fields

Syslog messages contain a [standardized header](https://tools.ietf.org/html/rfc5424#section-6) with several fields. These include the timestamp, the name of the  application that generated the event, the location in the system where  the message originated, and its priority. You can change this format in  your syslog implementation’s configuration file, but using the standard  format makes it easier to parse, [analyze](https://www.loggly.com/ultimate-guide/analyzing-linux-logs/), and route syslog events.

Here’s an example log message using the default format. It’s from the SSH daemon (sshd), which controls remote logins to the system. This  message describes a failed login attempt:

```
Jun 4 22:14:15 server1 sshd[41458] : Failed password for root from 10.0.2.2 port 22 ssh2
```

You can also add additional fields to your syslog messages. Let’s  repeat the last event after adding a few new fields. We’ll use the  following rsyslog template, which adds the priority (<%pri%>),  protocol version (%protocol-version%), and the date formatted using [RFC 3339](https://tools.ietf.org/html/rfc3339) (%timestamp:::date-rfc3339%):

```
<%pri%>%protocol-version% %timestamp:::date-rfc3339% %HOSTNAME% %app-name% %procid% %msgid% %msg%n
```

This generates the following log:

```
<34>1  2019-06-05T22:14:15.003Z server1 sshd - - pam_unix(sshd:auth):  authentication failure; logname= uid=0 euid=0 tty=ssh ruser=  rhost=10.0.2.2
```

Below, you’ll find descriptions of some of the most commonly used syslog fields when searching or [troubleshooting issues](https://www.loggly.com/ultimate-guide/troubleshooting-with-linux-logs/).

### [Priority](https://tools.ietf.org/html/rfc5424#section-6.2.1)

The priority field or [pri](https://tools.ietf.org/html/rfc5424#section-6.2.1) for short (“<34>” in the example) tells you how urgent or severe  the event is. It’s a combination of two numerical fields: the facility  and the severity. The facility specifies the type of process that  created the event, ranging from 0 for kernel messages to 23 for local  applications. The severity ranges from 0 – 7, with 0 indicating an  emergency and 7 indicating a debug event.

Pri can be output in two ways. The first is as a single number,  prival, which is calculated as the facility field value multiplied by  eight; then, the result is added to the severity field value:  (facility)(8) + (severity). The second is pri-text, which will output in the string format “facility.severity”. The latter format is often  easier to read and search but takes up more storage space.

### Timestamp

The [timestamp](https://tools.ietf.org/html/rfc5424#section-6.2.3) field (“2019-06-05T22:14:15.003Z” in the above example) indicates the  time and date the message was generated on the system sending the  message. The example timestamp breaks down like this:

- “2019-06-05” is the year, month, and day.
- “T” is a required element of the timestamp field, separating the date and the time.
- “22:14:15.003” is the 24-hour format of the time, including the number of milliseconds (003).
- “Z” indicates UTC time. Instead of Z, the example could have  included an offset, such as -08:00, which indicates that the time is  offset from UTC by eight hours.

### [Hostname](https://tools.ietf.org/html/rfc5424#section-6.2.4)

The [hostname](https://tools.ietf.org/html/rfc5424#section-6.2.4) field (“server1” in the example) indicates the name of the host or system that originally sent the message.

### [App-name](https://tools.ietf.org/html/rfc5424#section-6.2.5)

The [app-name](https://tools.ietf.org/html/rfc5424#section-6.2.5) field (“sshd:auth in the example) indicates the name of the application that sent the message.

## Logging with systemd

Many Linux distributions ship with systemd—a process and service  manager. Systemd implements its own logging service called journald,  which can replace or complement Syslog. Journald logs in a significantly different manner than systemd, which is why it has [its own section in the Ultimate Guide to Logging](https://www.loggly.com/ultimate-guide/using-journalctl/). You can learn more about logging via systemd in the [Systemd Logging](https://www.loggly.com/ultimate-guide/category/systemd/) section.

## /var/log  

This is such a crucial folder on your Linux systems. Open up a terminal window and issue the command *cd /var/log*. Now issue the command ls and you will see the logs housed within this directory (Figure 1).

![img](https://www.linuxfoundation.org/hubfs/Imported_Blog_Media/logs_a-1.jpg)

Figure 1: A listing of log files found in /var/log/.   

Now, let’s take a peek into one of those logs.

## Viewing logs with less

One of the most important logs contained within /var/log is syslog. This particular log file logs everything except auth-related messages. Say you want to view the contents of that particular log file. To do that, you could quickly issue the command less /var/log/syslog. This command will open the syslog log file to the top. You can then use the arrow keys to scroll down one line at a time, the spacebar to scroll down one page at a time, or the mouse wheel to easily scroll through the file.

The one problem with this method is that syslog can grow fairly large; and, considering what you’re looking for will most likely be at or near the bottom, you might not want to spend the time scrolling line or page at a time to reach that end. Will syslog open in the less command, you could also hit the [Shift]+[g] combination to immediately go to the end of the log file. The end will be denoted by (END). You can then scroll up with the arrow keys or the scroll wheel to find exactly what you want.

This, of course, isn’t terribly efficient.

## Viewing logs with dmesg

The dmesg command prints the kernel ring buffer. By default, the  command will display all messages from the kernel ring buffer. From the  terminal window, issue the command dmesg and the entire kernel ring  buffer will print out (Figure 2).

![img](https://www.linuxfoundation.org/hubfs/Imported_Blog_Media/logs_b-1.jpg)

Figure 2: A USB external drive displaying an issue that may need to be explored.

Fortunately, there is a built-in control mechanism that allows you to print out only certain facilities (such as daemon).

Say you want to view log entries for the user facility. To do this, issue the command dmesg –facility=user. If anything has been logged to that facility, it will print out.

Unlike the less command, issuing dmesg will display the full contents of the log and send you to the end of the file. You can always use your scroll wheel to browse through the buffer of your terminal window (if applicable). Instead, you’ll want to pipe the output of dmesg to the less command like so:

```dmesg | less```

The above command will print out the contents of dmesg and allow you to scroll through the output just as you did viewing a standard log with the less command.

## Viewing logs with tail

The tail command is probably one of the single most handy tools you have at your disposal for the viewing of log files. What tail does is output the last part of files. So, if you issue the command tail /var/log/syslog, it will print out only the last few lines of the syslog file.
But wait, the fun doesn’t end there. The tail command has a very important trick up its sleeve, by way of the   -f option. When you issue the command  tail -f /var/log/syslog, tail will continue watching the log file and print out the next line written to the file. This means you can follow what is written to syslog, as it happens, within your terminal window (Figure 3). 

![img](https://www.linuxfoundation.org/hubfs/Imported_Blog_Media/logs_c-1.jpg)

Figure 3: Following /var/log/syslog using the tail command.

Using tail in this manner is invaluable for troubleshooting issues.

To escape the tail command (when following a file), hit the [Ctrl]+[x] combination.

You can also instruct tail to only follow a specific amount of lines. Say you only want to view the last five lines written to syslog; for that you could issue the command:

```tail -f -n 5 /var/log/syslog```

The above command would follow input to syslog and only print out the most recent five lines. As soon as a new line is written to syslog, it would remove the oldest from the top. This is a great way to make the process of following a log file even easier. I strongly recommend not using this to view anything less than four or five lines, as you’ll wind up getting input cut off and won’t get the full details of the entry.

## There are other tools

You’ll find plenty of other commands (and even a few decent GUI tools) to enable the viewing of log files. Look to *more, grep, head, cat, multitail,* and [System Log Viewer](https://help.gnome.org/users/gnome-system-log/) to aid you in your quest to troubleshooting systems via log files.