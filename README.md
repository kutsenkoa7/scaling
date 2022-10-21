# scaling
Source code for the article
   https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4207464
   and for Figure 8 in
   https://www.essoar.org/doi/10.1002/essoar.10512519.1 

This is the implementation of the Resize-and-Average method which allows
us to compute the distribution of energies over scales - the alternative to the
classical Fourier transform is based on the Walsh--Rademacher bases functions
instead of sin and cos.

The input is a 2D array of velocities - examples are available in anton1956 folder.
For the second article, the input was generated in another program - a chanel simulator.
The examples from the folder anton1956 are also generated by this chanel simulator.
(We did not upload all the files for the second article since GitHub has limitations on the number of files.) 

The output are the files with the distribution of energies over scales - numerical
and graphical formats.  

The output for 10 days (from the folder anton1956) is in the corresponding '.pdf' files. The difference with the Figure 8 in the second paper is due to the fact that for Figure 8 the number of days is 365x9 for the period 1949-1957.

To obtain the output one should call

testdisstr;

in new2.dpr and after that

averag_ln;
drawleen2_ln; 

for the energy density distribution and then

averag;
drawleen2;

for the dissipation spectra.

Operating System: Windows;
Programming language: Delphi   (https://www.embarcadero.com/products/delphi/starter);
Additional libraries: MtxVec  [highly optimized implementation of basic linear
                              algebra rutines from Blas and Lapack based on Intel MKL]
                              (https://www.dewresearch.com/products/137-mtxvec-v4);
                      MikTex or TexLive  [for figures] (https://miktex.org/) (https://www.tug.org/texlive/)


ALL THE FILES WITH SOURCE CODE ARE PROVIDED FOR INFORMATIONAL PURPOSES ONLY.

The complete documentation, some optimized routines, the projection of unstructured grids
onto the square grid, and the graphical interface will probably be available in a "commercial version", someday:). 



