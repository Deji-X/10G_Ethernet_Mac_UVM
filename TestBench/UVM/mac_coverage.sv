covergroup mac_cg with function sample(int unsigned length,
                                       bit fcs_ok,
                                       bit backpressure_seen,
                                       int unsigned ifg_class);
    length_cp: coverpoint length {
        bins runt = {[0:45]};
        bins minimum = {46};
        bins normal = {[47:1500]};
        bins jumbo = {[1501:9000]};
        bins very_large = {[9001:9216]};
    }
    fcs_cp: coverpoint fcs_ok;
    backpressure_cp: coverpoint backpressure_seen;
    ifg_cp: coverpoint ifg_class { bins short_ifg={0}; bins nominal_ifg={1}; bins long_ifg={2}; }
    length_x_fcs: cross length_cp, fcs_cp;
    length_x_bp: cross length_cp, backpressure_cp;
endgroup
