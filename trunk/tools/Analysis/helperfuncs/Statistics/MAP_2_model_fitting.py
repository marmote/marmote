import numpy as np

################################################################################
def D01_45(r_1, h_2, h_3, b, c, gamma):
    t1 = 2*h_2 + b - c
    t2 = 2*h_2 + b + c

    D_0 = 1/(2*r_1*h_3) * np.array([[-t1, 0], [0, -t2]])

    tmp2 = 1 - b/c + gamma*(1 + b/c)
    tmp3 = (1 + b/c)*(1 - gamma)
    tmp4 = (1 - b/c)*(1 - gamma)
    tmp5 = 1 + b/c + gamma*(1 - b/c)
    D_1 = 1/(4*r_1*h_3) * np.array([ [t1*tmp2, t1*tmp3], [t2*tmp4, t2*tmp5] ])

    return D_0, D_1


################################################################################
def D01_1819( r_1, h_2, h_3, a, b, c, gamma ):
    t1 = 2*h_2 + b - c
    t2 = 2*h_2 + b + c

    tmp2 = (1 - a)*t1 + 2*c
    d_1 = ((1 - a)*(2*h_2*gamma + b - c) + gamma*(b + c) - (b - c)) / tmp2
    d_2 = (gamma - 1)*(b - c) / tmp2

    D_0 = 1/(2*r_1*h_3) * np.array([[-t1, t1*(1-a)], [0, -t2]])
    D_1 = 1/(2*r_1*h_3) * np.array([[t1*d_1, t1*(a-d_1)], [t2*d_2, t2*(1-d_2)]])

    return D_0, D_1


################################################################################
def MAP_2_model_fitting(time_diffs):
    D_0 = np.array([])
    D_1 = np.array([])

    #Step 1.
    E_1 = np.mean( np.power( time_diffs, 1) )
    E_2 = np.mean( np.power( time_diffs, 2) )
    E_3 = np.mean( np.power( time_diffs, 3) )
    r_1 = E_1/1
    r_2 = E_2/2
    r_3 = E_3/6
    cov = np.cov([time_diffs[:-1], time_diffs[1:]])[0][1]

    #Step 2.
    if r_1 <= 0:
        print "r_1 <= 0 Exiting..."

    #Step 3.
    h_2 = (r_2 - r_1**2)/(r_1**2)
    h_3 = (r_3*r_1 - r_2**2)/(r_1**4)

    #Step 4.
    if h_2 == 0:
        print "h_2 == 0 No MAP(2) can be fitted, equivalent to a simple Poisson process. Exiting..."

    #Step 5.
    gamma = cov/(r_2 - r_1**2)

    #Step 6.    
    b = h_3 + h_2**2 - h_2
    c = np.sqrt( b**2 + 4*h_2**3 )

    #Step 7.
    if h_2 > 0 and h_3 > 0:
    #Step 8. Hyperexponential case
        print "Hyperexponential"

        if b >= 0:
            if (b-c)/(b+c) <= gamma and gamma < 1:
                D_0, D_1 = D01_45(r_1, h_2, h_3, b, c, gamma)

            else:
                print "Correlation parameters out of bound. Exiting..."
        else:
            if 0 <= gamma and gamma < 1:
                D_0, D_1 = D01_45(r_1, h_2, h_3, b, c, gamma)

            elif -(h_3 + h_2**2)/h_2 <= gamma and gamma < 0:
                a = (h_3 + h_2**2)/h_2

                D_0, D_1 = D01_1819(r_1, h_2, h_3, a, b, c, gamma)

            else:
                print "Correlation parameters out of bound. Exiting..."
    elif -0.25 <= h_2 and h_2 < 0 and h_2 * ( 1 - h_2 - 2*np.sqrt(-h_2) ) <= h_3 and h_3 <= -h_2**2:
    #Step 9. Hypoexponential case
        print "Hypoexponential"

        if gamma >= 0:
            if gamma <= -( h_2 + np.sqrt(-h_3) )**2/h_2:
                a = ( 2*h_2 + b - c )*( h_2 + np.sqrt(-h_3) )/( 2*h_2*np.sqrt(-h_3) )

                D_0, D_1 = D01_1819(r_1, h_2, h_3, a, b, -c, gamma)
            else:
                print "Correlation parameters out of bound. Exiting..."
        else:
            if gamma >= -(h_3 + h_2**2)/h_2:
                a = (h_3 + h_2**2)/h_2

                D_0, D_1 = D01_1819(r_1, h_2, h_3, a, b, -c, gamma)
            else:
                print "Correlation parameters out of bound. Exiting..."
    else:
        print "Moments out of bounds. Exiting..."

    return D_0, D_1


################################################################################
if __name__ == "__main__":

    time_diffs = [1.89151200e+00,   1.07704800e+00,   4.37640000e-01,   1.51368000e-01,
    7.12320000e-02,   2.18400000e-03,   3.61200000e-02,   7.17360000e-02,
    8.53876800e+00,   1.17539520e+01,   2.90892000e+00,   1.46160000e-02,
    3.68088000e+00,   1.48512000e-01,   2.64415200e+00,   7.00744800e+00,
    1.83086400e+00,   2.38929600e+00,   3.32169600e+00,   1.60389600e+00,
    2.92538400e+00,   2.75856000e+00,   6.08949600e+00,   4.99584960e+01,
    4.49164800e+00,   1.79860800e+00,   2.53468320e+01,   3.23114400e+00,
    1.50395280e+01,   6.08160000e-02,   4.00848000e-01,   3.39528000e-01,
    1.06125600e+00,   4.01016000e-01,   1.29225600e+00,   2.18400000e-03,
    3.03744000e-01,   8.01864000e-01,   1.80280800e+00,   3.98832000e-01,
    1.14139200e+00,   2.68800000e-03,   1.00027200e+00,   2.18400000e-03,
    6.09840000e-02,   9.15600000e-02,   5.37600000e-03,   4.45368000e-01,
    6.04800000e-02,   7.43064000e-01,   7.01904000e-01,   6.06480000e-02,
    4.00848000e-01,   9.44832000e-01,   9.25680000e-02,   4.70736000e-01,
    1.34400000e-03,   7.40712000e-01,   2.68800000e-03,   3.59856000e-01,
    1.14727200e+00,   6.38400000e-02,   1.50964800e+00,   6.07320000e-01,
    1.00632000e-01,   4.31760000e-01,   2.71992000e-01,   7.46760000e-01,
    9.69360000e-01,   6.06312000e-01,   2.62802400e+00,   1.61548800e+00,
    4.30214400e+00,   2.65104000e-01,   4.74467280e+01,   5.99457600e+00,
    5.88000000e-03,   4.70400000e-03,   6.14342400e+00,   2.94453600e+00,
    6.00667200e+00,   1.14928800e+00,   6.73209600e+00,   5.26428000e+00,
    1.20960000e-01,   7.95312000e-01,   3.98781600e+00,   8.16631200e+00,
    1.33560000e-01,   2.02154400e+00,   1.67160000e-01,   5.11896000e+00,
    7.96404000e+00,   1.06512000e-01,   2.80106400e+00,   1.08528000e-01,
    3.05289600e+00,   2.27673600e+00,   1.09216800e+00,   6.87120000e-02,
    4.14002400e+00,   5.02034400e+00,   3.28305600e+00,   6.58761600e+00,
    1.53921600e+00,   5.51577600e+00,   1.17600000e-03,   5.50872000e-01,
    3.20628000e+00,   1.77206400e+00,   7.76328000e-01,   1.88512800e+00,
    1.03104960e+01,   3.97975200e+00,   1.98475200e+00,   2.19240000e-01,
    2.20752000e-01,   3.32640000e-01,   1.09536000e-01,   4.03200000e-02,
    6.92160000e-02,   1.09704000e-01,   7.03248000e-01,   6.83760000e-02,
    2.75234400e+00,   4.37808000e-01,   7.68096000e-01,   1.14408000e-01,
    2.43600000e-02,   4.56792000e-01,   5.04168000e-01,   2.19357600e+00,
    4.06560000e-02,   2.81064000e+00,   1.75140000e+00,   1.07352000e-01,
    7.20199200e+00,   1.52426400e+00,   1.18137600e+00,   1.46764800e+00,
    1.09032000e-01,   6.61920000e-02,   1.50336480e+01,   3.23400000e-01,
    3.87088800e+00,   2.13696000e-01,   1.07469600e+00,   1.72267200e+00,
    4.21680000e-01,   1.39574400e+00,   3.29280000e-02,   5.03160000e-01,
    1.01288880e+01,   1.64472000e-01,   9.51720000e-01,   1.23900000e+00,
    2.54990400e+00,   7.42056000e-01,   9.53904000e-01,   1.59012000e+00,
    1.06041600e+00,   1.36365600e+00,   2.44423200e+00,   3.27499200e+00,
    6.19584000e-01,   8.14578240e+01,   7.03416000e-01,   4.01184000e-01,
    2.40912000e-01,   1.36617600e+00,   1.24168800e+00,   2.85600000e-03,
    5.99760000e-02,   4.40496000e-01,   6.24960000e-02,   5.39616000e-01,
    1.04160000e-02,   1.52376000e-01,   1.13870400e+00,   6.41760000e-02,
    9.79440000e-02,   5.01816000e-01,   3.83040000e-02,   6.18240000e-02,
    1.99752000e-01,   1.60154400e+00,   3.00048000e-01,   1.13652000e+00,
    6.60240000e-02,   4.00344000e-01,   1.03689600e+00,   6.23280000e-02,
    3.51960000e-01,   9.89688000e-01,   6.04800000e-02,   1.01472000e-01,
    2.23440000e+00,   6.32856000e-01,   1.81776000e-01,   5.77920000e-02,
    4.44024000e-01,   5.96400000e-02,   1.64304000e+00,   2.68128000e+00,
    6.03960000e-01,   6.57073200e+01,   7.32480000e-02,   2.87280000e-02,
    4.89316800e+00,   1.68168000e-01,   2.38190400e+00,   1.96677600e+00,
    6.29832000e-01,   1.33056000e-01,   3.76353600e+00,   5.84589600e+00,
    1.29679200e+00,   1.14794400e+00,   1.43606400e+00,   1.80297600e+00,
    2.37854400e+00,   2.01583200e+00,   4.26636000e+00,   6.68640000e-02,
    7.84224000e-01,   8.14800000e-01,   2.07093600e+00,   1.07856000e-01,
    1.02883200e+00,   1.71276000e+00,   1.43236800e+00,   6.73680000e-02,
    1.10208000e-01,   1.09536000e-01,   1.32552000e-01,   5.45664000e-01,
    6.83760000e-02,   1.41456000e-01,   8.73600000e-03,   5.99592000e-01,
    1.39977600e+00,   4.25208000e-01,   6.42600000e-01,   1.50864000e-01,
    2.85835200e+00,   1.19145600e+00,   1.02832800e+00,   7.31304000e-01,
    6.98880000e-02,   1.38600000e-01,   6.14544000e-01,   7.56000000e-01,
    5.36088000e-01,   2.35200000e-03,   1.07016000e-01,   3.22560000e-02,
    1.58995200e+00,   1.00800000e-01,   3.30624000e-01,   2.15208000e-01,
    4.34616000e-01,   4.70232000e-01,   2.18064000e-01,   6.95520000e-02,
    1.07520000e-01,   6.48480000e-01,   2.92320000e+00,   4.33104000e-01,
    1.08578400e+00,   3.24240000e-01,   5.42304000e-01,   4.32936000e-01,
    4.37136000e-01,   6.47808000e-01,   6.57048000e-01,   2.16216000e-01,
    3.29784000e-01,   3.47827200e+00,   5.99944800e+00,   6.56376000e-01,
    2.20920000e-01,   1.52829600e+00,   2.23104000e-01,   1.20271200e+00,
    4.38312000e-01,   6.56880000e-01,   1.49856000e-01,   1.79592000e-01,
    1.97332800e+00,   3.31632000e-01,   8.76120000e-01,   4.40160000e-01,
    5.50704000e-01,   1.97820000e+00,   2.21760000e-01,   8.78808000e-01,
    5.00186400e+00,   1.50427200e+00,   4.48224000e-01,   2.18736000e-01,
    1.21497600e+00,   4.82664000e-01,   1.06612800e+00,   1.09519200e+00,
    3.87576000e-01,   1.45824000e-01,   3.70104000e-01,   8.86536000e-01,
    3.74640000e-02,   1.73527200e+00,   2.24280000e-01,   5.32778400e+00,
    1.65866400e+00,   2.63088000e-01,   1.77240000e-01,   4.47552000e-01,
    2.10336000e+00,   1.76416800e+00,   1.76736000e+00,   1.54257600e+00,
    4.41336000e-01,   1.32333600e+00,   1.08948000e+00,   4.51533600e+00,
    3.28944000e-01,   4.01520000e-02,   4.00344000e-01,   3.02400000e-03,
    2.15880000e-01,   1.09704000e+00,   1.09032000e-01,   6.57048000e-01,
    1.09032000e-01,   3.25752000e-01,   4.40664000e-01,   4.59580800e+00,
    2.56200000e-01,   3.34656000e-01,   2.83584000e-01,   4.35120000e-01,
    2.72563200e+00,   2.19072000e-01,   1.52460000e+00,   1.23631200e+00,
    6.98880000e-02,   2.16216000e-01,   3.27936000e-01,   1.08528000e+00,
    1.09200000e-01,   3.26760000e-01,   2.56704000e-01,   6.93840000e-02,
    4.18824000e-01,   1.73040000e-02,   2.38560000e+00,   2.81752800e+00,
    4.32264000e-01,   6.69648000e+00,   6.88464000e-01,   1.66152000e-01,
    4.41336000e-01,   6.86448000e-01,   1.46680800e+00,   2.50656000e-01,
    3.94128000e-01,   1.38936000e-01,   4.38816000e-01,   1.34769600e+00,
    9.25848000e-01,   1.01488800e+00,   2.18232000e-01,   1.43388000e+00,
    6.87120000e-02,   2.18148000e+00,   6.72000000e-02,   2.54184000e-01,
    1.39406400e+00,   9.59952000e-01,   8.16480000e-01,   2.11176000e-01,
    1.48344000e-01,   9.61128000e-01,   6.77040000e-02,   1.81305600e+00,
    2.15040000e-01,   1.05840000e-01,   8.10600000e-01,   7.52640000e-02,
    2.83752000e-01,   3.19771200e+00,   1.05336000e-01,   3.33496800e+00,
    7.47532800e+00,   9.10308000e+01,   5.33232000e-01,   1.67160000e+00,
    8.02536000e-01,   8.35464000e-01,   1.72704000e-01,   2.51328000e-01,
    1.10241600e+00,   4.32096000e-01,   5.00472000e-01,   4.42680000e-01,
    6.21600000e-02,   7.00896000e-01,   2.38224000e-01,   2.52000000e-03,
    6.99552000e-01,   7.39200000e-03,   2.19660000e+00,   3.36000000e-03,
    4.58136000e-01,   8.45208000e-01,   8.99976000e-01,   6.63045600e+00,
    3.02568000e-01,   5.04168000e-01,   2.01768000e-01,   8.19100800e+00,
    1.01304000e-01,   2.56324320e+01,   3.08616000e-01,   1.23530400e+00,
    2.71704720e+01,   4.29156000e+00,   4.19764800e+00,   2.00037600e+00,
    6.85322400e+00,   6.74352000e-01,   2.77536000e-01,   1.26924000e+00,
    6.74520000e-01,   6.60240000e-02,   1.30939200e+00,   1.05991200e+00,
    3.40368000e-01,   4.65864000e-01,   6.37056000e-01,   6.40080000e-01,
    1.75946400e+00,   8.39496000e-01,   9.45336000e-01,   6.51840000e-02,
    1.31275200e+00,   1.73208000e-01,   1.02950400e+00,   7.81872000e-01,
    2.15544000e-01,   9.58272000e-01,   3.58680000e-01,   2.94655200e+00,
    2.14704000e-01,   2.13024000e-01,   3.22224000e-01,   7.48944000e-01,
    9.62472000e-01,   2.52336000e-01,   2.80224000e-01,   2.15880000e-01,
    4.67040000e-01,   3.89760000e-01,   5.76576000e-01,   6.63600000e-02,
    7.75992000e-01,   3.16680000e-01]

    D_0, D_1 = MAP_2_model_fitting(time_diffs)
