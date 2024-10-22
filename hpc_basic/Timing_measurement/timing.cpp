///////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
//   Usage:
//           ./program -nx X  -nt T 
//           X:   number of gridpoints in x-direction (default = 1024)
//           T:   number of iterations to run for (default = 100)
//
//   Description:
//           Computes a[1:nx] = -a[1:nx] T times (nx = 128)
//           Reports time
//
////////////////////////////////////////////////////////////////////////
#include <iostream>
#include <string>
#include <fstream>
#include <ctime>

using namespace std;



int main(int argc, char** argv) {
    int niter=100000;
    int nx=1024;
    std::string::size_type sz;
    string mystr;
    double a[128];


    std::clock_t tstart;
    std::clock_t tend;
    double elapsed;

    

    ///////////////////////////////////////
    //  Read command-line parameters

   
    for (int i=0; i < argc; i++) {
        mystr=argv[i];
        if (mystr == "-niter"){
            niter=atoi(argv[i+1]);
        }
    }
  

    cout << "Looping " << niter << " times."   << endl;




    //////////////////////////////////////////
    // Initialize
    for (int i = 0; i < 128; i++) {
        a[i] = i;

    }

    
    /////////////////////////////
    //  Time loop (computes a = a*b+c {niter} times)
    tstart=std::clock();
    for (int j = 1; j<=niter; j++) {

        for (int i = 1; i < 128; i++) {
            a[i] = -a[i];
        }

    }
    tend=std::clock();
    elapsed = (tend-tstart)/(double) CLOCKS_PER_SEC;
    cout << "Elapsed time: " << elapsed << endl;


}
