# nn22 Basic Neural Networks for Octave

About nn22 Basic Neural Networks (NN) framework for Octave (or Matlab)
----------------------------------------------------------------------
nn22 is a small and basic NN framework that was built having the
following criteria in mind.
1. Function as a close-to all purpose NN framework allowing to
   define a NN with:
   a. as many layers as you want,
   b. as many neurons per layer as you want,
   c. the activation function per layer that you want,
   d. the ability to feed back as many delayed outputs as you want,
   e. the ability to delay the input vector as many times...
   f. ...and other stuff, and do so in an easy way.
2. To have its main functions logically separated and uncluttered
   so that the may be modified at will and easily understood.
3. To have all source code available at plain sight, nothing hidden
   inside an obscure library.
4. The possibility to insert 'keyboard;' breaks at any point of the
   code so that all variables and functions behavior can be
   evaluated through 'who' and commands alike.
5. To be able to run in both Octave and Matlab.
6. To serve a didactic purpose.


What nn22 is not:
-----------------
1. It is not a full featured NN framework.
2. It is not fast.
3. It is not intended to work as a commercial product does.
4. It is not even intended to pair other open source frameworks 
   available that are indeed fast and provide good results.
5. ...and this renders the previous stated objective: 
   it has a didactic purpose. And just that :)


How nn22 came to see the light?
-------------------------------
1. There is a specialization course taught by Dr. Eng. Daniel Patino at
   the INAUT institute, Universidad Nacional de San Juan, Argentina,
   called "Neural Networks Applied to System's Identification and 
   Control" ("Redes Neuronales Aplicadas a la Identificacion y Control
   de Sistemas") and belongs to INAUT's MSc and PhD programs.
2. The author of this code (that would be me, Alejandro) attended 
   professor Patino's classes.
3. One of the course's assignments was to build simple NN solutions
   for the AND, XOR, SINE, FIR and other problems, including a 
   multi-input multi-output non-linear dynamic system's identification,
   ...yes, true, that one is not that simple.
4. The author of the code got engaged and did an extra mile,
   for the sake of machine learning coding joyfulness, sort of ;)


Expected future for nn22:
-------------------------
1. To serve as a didactic means of learning the insights of NN.
2. To have some other training strategies added.
3. To grow in functions that underline its didactic purpose.


OK now,

How to use:
-----------
1. From Octave's command line load nn22.m (you may use Matlab).
2. Follow the menu indications, by either loading or creating a
   new Neural Network.
3. Data for training and testing is included in .txt files. Or you may
   create new data.
4. Adjust constants for training.
5. Train, feed the NN and plot results.
6. Spare some time understanding the code, should be 
   pretty straight forward.
7. The neural network structure is:
   a) easily modified by its .ini file.
   b) visible in the neurons data structure included in each .mat file.
8. This very simple framework is meant to provide a means to play and
   understand neural networks basics. Nothing more than that.
9. Profound knowledge of Trial and Error is a must.


Some 'advanced' how to use:
---------------------------
1. Files particular to each NN solution are included as examples and
   as templates to be modified to suit your own NN solution.
    a) and_Structure.ini
    b) and_Constants.m
    c) and_nnData.mat
    d) and_createIOdata.m
    e) and_plotIOdata.m
    f) and_ioIdealTest.txt
    g) and_ioIdealTrain.txt
    h) and_ioInputTest.txt
    i) and_ioInputTrain.txt
    ...where 'and' should be replaced by your NN's Base Name,
    e.g.: xor, sine, fir, etc. (etc. meaning your own base name ;)
2. File a) is the .ini NN structure definition. Edit it.
3. Files b) and c) may be omitted, but if they exist, you should respect
   their existence. They may contain useful information regarding the NN :)
   If they do not exist, they will be created by the program.
4. Files d) and e) are templates and *have to* be adapted to your solution.
5. Files f) to i) are the .txt data files. If they do not exist,
   the program can create them. There is a menu option for that task...
   and it calls the function listed as file d) _createIOdata.m
   It should be easy to build your own data set for a particular solution.

One step further, extend Localization languages:
------------------------------------------------
1. There are three files that contain localization info:
    a) nn_localization.m
    b) nn_localization_en_US.m
    c) nn_localization_es_AR.m
2. File a) is called at the very beginning of nn22.m and helps the user
   to choose between files b), c), and perhaps other localized files that
   may be added in the future.
3. Files b) and c) contain the localized messages and are twin files
   with the same number of lines, containing the same structure variable
   declarations, all belonging to the 'msG' global structure, one of them
   assigns messages in English language and the other in Spanish.
4. In order to add another language you may add an edited copy of file b)
   and then add another option to file a). You may also follow the brief
   instructions included at the end of the a) file, 'nn_localization.m'.
   

   
Final comments:
---------------
The project consists of a few very simple .m files for a Basic
Neural Networks study under Octave (or Matlab).

The idea is to provide a context for beginners that will allow to
develop neural networks, while at the same time get to see and feel
the behavior of a basic neural networks' functioning.

The code is completely open to be modified and may suit several scenarios.

The code commenting is verbose, and variables and functions do respect
English formatting, so that code may be self explanatory.

Messages to the screen are localized, both in English and Spanish,
and it is really easy to add another language to the localization.

If any further explanation is needed, the forum/discussion page
may be of help :) 

Comments and suggestions are very welcome. 



Copyright statement:
--------------------
Copyright (C) 2014 Alejandro Quiroga Alsina

The copyright is made under GNU General Public License.
README.txt, COPYING.txt and LICENSE.txt files add info on this regard.
