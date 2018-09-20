# Sigma Workshop

## Content

This repository contains content and scripts for setting up an Elasticsearch and Kibana environment with logs
of a Windows system where some typical attack tools were executed:

* [Mimikatz](https://github.com/gentilkiwi/mimikatz)
* [NirSoft NetPass](https://www.nirsoft.net/utils/network_password_recovery.html)
* [Windows Credential Editor](https://www.ampliasecurity.com/research/windows-credentials-editor/)
* [Red Team Automation](https://github.com/endgameinc/RTA)

The logs contain events from [Sysmon 8.0](https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon) in
the [SwiftOnSecurity configuration](https://github.com/SwiftOnSecurity/sysmon-config) in addition to the
default Windows system, security and application logs.

Further, the [Sigma repository](https://github.com/Neo23x0/sigma) is contained
as submodule. Clone this repository as follows to get it all:

```
git clone --recursive https://github.com/thomaspatzke/sigma-workshop.git
```

## Installation

First, the Elasticsearch/Kibana stack has to be started with Docker compose:

```
docker-compose -f es_kibana.docker-compose.yml up
```

This takes a while. Please wait until the environment is running. You can verify this by invocation of 
[Kibana](http://localhost:5601). If no errors regarding the availability of Elasticsearch are shown, the
environment should be ready.

**WARNING:** The usage of the following mentioned script destroys possibly existing Kibana configuration!
Don't use this on productive systems or where you don't want this to happen!

Install the index templates, log index and Kibana configuration index by invocation of
`./sigma_workshop_prepare_es.sh`.

If you plan to use an existing Elasticsearch installation for this workshop, you can also give the host and
port as first parameter to the command line: `./sigma_workshop_prepare_es.sh elk:9201`

## Usage

The logs are contained in the time frame between 14:45 and 15:20 on 2018-09-19 and can be viewed in
[Kibana](http://localhost:5601/app/kibana#/discover?_g=(refreshInterval:(pause:!t,value:0),time:(from:'2018-09-19T12:39:20.110Z',mode:absolute,to:'2018-09-19T13:24:08.109Z'))).
