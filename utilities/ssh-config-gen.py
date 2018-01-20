#!env python3

import sys

# Script to generate an ssh config file which sets nice aliases to the 
# cs machines

def mkEntry(name, host):
    print("Host", name);
    print("\tHostName " + host + ".cs.purdue.edu");
    print("\tUser " + sys.argv[1]);

def labHosts(name, n):
    mkEntry(name, name + "00");
    for host in range(n):
        mkEntry(name + str(host).zfill(2), name + str(host).zfill(2));
    print();

def clusterHosts(name, n, m):
    mkEntry(name, name + "0-0");
    for cluster in range(n):
        for host in range(m):
            mkEntry(name + str(cluster) + "-" + str(host), 
                    name + str(cluster) + "-" + str(host));
    print();

for lab in ["sslab", "escher", "borg", "xinu", "moore"]:
    labHosts(lab, 25);

clusterHosts("pod", 5, 5);

for server in ["data", "cuda", "mc18", "lore", "mctesla"]:
    mkEntry(server, server);
