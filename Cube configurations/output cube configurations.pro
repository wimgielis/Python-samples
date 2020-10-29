601,100
602,"_"
562,"NULL"
586,
585,
564,
565,"aa8PsgkFFr1P=i0sBfpgCNXW3XcWYw_QkV:UcUbk>tRYs5B:Q50T>=EtipbBG4Z_t4NXS<x\j\3xYQf@lScvQ6mVxAOc8Vfa_4ZtiXJt;qbF4bqT]CcIBslJa]ty^1_fB0[a6aHguylXPmTeAZfb>Dl0[_W8f3zhX5:S0g92U<0wL7K3lz2WyWwT1EAndbQA`@PiRmhH"
559,1
928,0
593,
594,
595,
597,
598,
596,
800,
801,
566,0
567,","
588,","
589," "
568,""""
570,
571,
569,0
592,0
599,1000
560,0
561,0
590,0
637,0
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,261

#****Begin: Generated Statements***
#****End: Generated Statements****


####################################################
# Wim Gielis
# October 2020
# https://www.wimgielis.com
####################################################


# Where do we output text files ?
cDestination_Folder = GetProcessErrorFileDirectory | 'TM1 output\Cubes and dimensions\';
If( FileExists( cDestination_Folder ) = 0 );
   ExecuteCommand( Expand( 'cmd /c "md "%cDestination_Folder%""' ), 1 );
EndIf;

DatasourceAsciiQuoteCharacter = '';


## Script the CubeCreate for all application cubes and output in a text file

vFile = cDestination_Folder | 'CubeCreate.txt';

# regular cubes
c = 1;
While( c <= Dimsiz( '}Cubes' ));

   vCube = Dimnm( '}Cubes', c );

   sOutput = '';

   If( Subst( vCube, 1, 1 ) @<> '}' );

      sOutput = sOutput | 'CubeCreate( ''' | vCube | ''', ';
      # sOutput = Expand( %sOutput%CubeCreate( ''%vCube%'', ''')' );

      d = 1;
      While( d <= CubeDimensionCountGet( vCube ));

         vDim = Tabdim( vCube, d );
         sOutput = sOutput | '''' | vDim | ''', ';
         # sOutput = Expand( '%sOutput%''%vDim%'', ' );

         d = d + 1;

      End;

      sOutput = Subst( sOutput, 1, Long( sOutput ) - 2 );
      sOutput = sOutput | ' );';
      TextOutput( vFile, sOutput );

   EndIf;

   c = c + 1;

End;

TextOutput( vFile, '' );

# control cubes
c = 1;
While( c <= Dimsiz( '}Cubes' ));

   vCube = Dimnm( '}Cubes', c );

   sOutput = '';

   If( Subst( vCube, 1, 1 ) @= '}' );

      sOutput = sOutput | 'CubeCreate( ''' | vCube | ''', ';

      d = 1;
      While( d <= CubeDimensionCountGet( vCube ));

         vDim = Tabdim( vCube, d );
         sOutput = sOutput | '''' | vDim | ''', ';

         d = d + 1;

      End;

      sOutput = Subst( sOutput, 1, Long( sOutput ) - 2 );
      sOutput = sOutput | ' );';
      TextOutput( vFile, sOutput );

   EndIf;

   c = c + 1;

End;


## Script the DB for all cubes and output in a text file

vFile = cDestination_Folder | 'DB.txt';

# regular cubes
c = 1;
While( c <= Dimsiz( '}Cubes' ));

   vCube = Dimnm( '}Cubes', c );

   sOutput = '';

   If( Subst( vCube, 1, 1 ) @<> '}' );

      sOutput = sOutput | 'DB( ''' | vCube | ''', ';

      d = 1;
      While( d <= CubeDimensionCountGet( vCube ));

         vDim = Tabdim( vCube, d );
         sOutput = sOutput | '!' | vDim | ', ';

         d = d + 1;

      End;

      sOutput = Subst( sOutput, 1, Long( sOutput ) - 2 );
      sOutput = sOutput | ' );';
      TextOutput( vFile, sOutput );

   EndIf;

   c = c + 1;

End;


TextOutput( vFile, '' );

# control cubes
c = 1;
While( c <= Dimsiz( '}Cubes' ));

   vCube = Dimnm( '}Cubes', c );

   sOutput = '';

   If( Subst( vCube, 1, 1 ) @= '}' );

      sOutput = sOutput | 'DB( ''' | vCube | ''', ';

      d = 1;
      While( d <= CubeDimensionCountGet( vCube ));

         vDim = Tabdim( vCube, d );
         sOutput = sOutput | '!' | vDim | ', ';

         d = d + 1;

      End;

      sOutput = Subst( sOutput, 1, Long( sOutput ) - 2 );
      sOutput = sOutput | ' );';
      TextOutput( vFile, sOutput );

   EndIf;

   c = c + 1;

End;





## Script the CellGetN for all cubes and output in a text file

vFile = cDestination_Folder | 'CellGetN.txt';

# regular cubes
c = 1;
While( c <= Dimsiz( '}Cubes' ));

   vCube = Dimnm( '}Cubes', c );

   sOutput = '';

   If( Subst( vCube, 1, 1 ) @<> '}' );

      sOutput = sOutput | 'CellGetN( ''' | vCube | ''', ';

      d = 1;
      While( d <= CubeDimensionCountGet( vCube ));

         vDim = Tabdim( vCube, d );

         Chars_to_Remove = ' {}';
         While( Long( Chars_to_Remove ) > 0 );
            Char_to_Remove = Subst( Chars_to_Remove, 1, 1 );
            While( Scan( Char_to_Remove, vDim ) > 0 );
               vScan = Scan( Char_to_Remove, vDim );
               vDim = Delet( vDim, vScan, 1 );
            End;
            Chars_to_Remove = Delet( Chars_to_Remove, 1, 1 );
         End;

         sOutput = sOutput | 'v' | vDim | ', ';

         d = d + 1;

      End;

      sOutput = Subst( sOutput, 1, Long( sOutput ) - 2 );
      sOutput = sOutput | ' );';
      TextOutput( vFile, sOutput );

   EndIf;

   c = c + 1;

End;


TextOutput( vFile, '' );

# control cubes
c = 1;
While( c <= Dimsiz( '}Cubes' ));

   vCube = Dimnm( '}Cubes', c );

   sOutput = '';

   If( Subst( vCube, 1, 1 ) @= '}' );

      sOutput = sOutput | 'CellGetN( ''' | vCube | ''', ';

      d = 1;
      While( d <= CubeDimensionCountGet( vCube ));

         vDim = Tabdim( vCube, d );

         Chars_to_Remove = ' {}';
         While( Long( Chars_to_Remove ) > 0 );
            Char_to_Remove = Subst( Chars_to_Remove, 1, 1 );
            While( Scan( Char_to_Remove, vDim ) > 0 );
               vScan = Scan( Char_to_Remove, vDim );
               vDim = Delet( vDim, vScan, 1 );
            End;
            Chars_to_Remove = Delet( Chars_to_Remove, 1, 1 );
         End;

         sOutput = sOutput | 'v' | vDim | ', ';

         d = d + 1;

      End;

      sOutput = Subst( sOutput, 1, Long( sOutput ) - 2 );
      sOutput = sOutput | ' );';
      TextOutput( vFile, sOutput );

   EndIf;

   c = c + 1;

End;
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,3

#****Begin: Generated Statements***
#****End: Generated Statements****
576,CubeAction=1511DataAction=1503CubeLogChanges=0
930,0
638,1
804,0
1217,0
900,
901,
902,
938,0
937,
936,
935,
934,
932,0
933,0
903,
906,
929,
907,
908,
904,0
905,0
909,0
911,
912,
913,
914,
915,
916,
917,0
918,1
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
