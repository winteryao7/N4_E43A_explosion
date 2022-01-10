from obspy.clients.fdsn import Client                                           
from obspy import UTCDateTime
 
client = Client("IRIS")
 
all_evs = open('allevs4download.dat','r');
pair_info = all_evs.readline();
 
while pair_info:
    pair_info_new = pair_info.split(' ');
    print(pair_info_new)
    evotime = pair_info_new[0];
    outmsd = pair_info_new[1].strip('\n');
# find start and endtime
    t = UTCDateTime(evotime);
    st = client.get_waveforms("N4", "E43A", "--", "?H?", t - 60, t + 120)
    st.write(outmsd, format="MSEED");
    pair_info = all_evs.readline();
 
all_evs.close();
