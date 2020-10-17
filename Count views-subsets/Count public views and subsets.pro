601,100
602,"Count public views and subsets"
562,"NULL"
586,
585,
564,
565,"stcM\T]B[s]ElBRv\D@auVrG?7vCimO]Wtbe6yUMxSitLX0Nl;KVq@c8NiFLpgNg4wFNSXIq3oEb9]fWD:5Gh@TrT;QWGTo`mo;BPt7hFQlivJ\7pUUeIsUr07lVnl3b6oNXJsNuLWSR2PxKoa3BC;\iys@^6lUfypk5MEBb[9HZF16r^L]m:H:HFccw\k6eor\qE=cI"
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
572,94

#****Begin: Generated Statements***
#****End: Generated Statements****


# Counting the number of public views and subsets in the model (for clean up purposes)

# The minimal number of public objects in order to track it in the text file output
cThreshold_views = 8;
cThreshold_subsets = 8;

# Where do we output a text file ?
output_filename = 'D:\count public views and subsets.txt';
DatasourceASCIIQuoteCharacter = '';
DatasourceASCIIDelimiter = Char( 9 );

sAttr_Cube = 'Count of public views';
CubeAttrDelete( sAttr_Cube );
CubeAttrInsert( '', sAttr_Cube, 'N' );

sAttr_Dim = 'Count of public subsets';
DimensionAttrDelete( sAttr_Dim );
DimensionAttrInsert( '', sAttr_Dim, 'N' );


# track the number of public views per cube
c = 1;
While( c <= Dimsiz( '}Cubes' ));

   vCube = Dimnm( '}Cubes', c );
   vDim_Views = '}Views_' | vCube;
   CubeAttrPutN( CubeAttrN( vCube, sAttr_Cube ) + Dimsiz( vDim_Views ), vCube, sAttr_Cube );

   c = c + 1;

End;

# track the number of public subsets per dimension
d = 1;
While( d <= Dimsiz( '}Dimensions' ));

   vDim = Dimnm( '}Dimensions', d );
   vDim_Subsets = '}Subsets_' | vDim;
   DimensionAttrPutN( DimensionAttrN( vDim, sAttr_Dim ) + Dimsiz( vDim_Subsets ), vDim, sAttr_Dim );

   d = d + 1;

End;


## generate a text file with the counts, in descending order
# public cube views
# output the number of public views per cube
TextOutput( output_filename, 'Public cube views: (at least ' | NumberToString( cThreshold_views ) | ' )' );
TextOutput( output_filename, Fill( '-', 35 ));
TextOutput( output_filename, '' );

sMDX = Expand( 'Order( Filter( TM1SubsetAll( [}Cubes] ), [}CubeAttributes].([}CubeAttributes].[%sAttr_Cube%]) > %cThreshold_views% ), [}CubeAttributes].([}CubeAttributes].[%sAttr_Cube%]), Desc)');
If( SubsetExists( '}Cubes', 'tmp' ) = 0 );
    SubsetCreate( '}Cubes', 'tmp' );
EndIf;
SubsetMDXSet( '}Cubes', 'tmp', sMDX );

c = 1;
While( c <= SubsetGetSize( '}Cubes', 'tmp' ));

   vCube = SubsetGetElementName( '}Cubes', 'tmp', c );
   TextOutput( output_filename, NumberToString( CubeAttrN( vCube, sAttr_Cube )), vCube );
   c = c + 1;

End;

TextOutput( output_filename, '' );
TextOutput( output_filename, '' );

# public dimension subsets
TextOutput( output_filename, 'Public dimension subsets: (at least ' | NumberToString( cThreshold_subsets ) | ' )' );
TextOutput( output_filename, Fill( '-', 35 ));
TextOutput( output_filename, '' );

sMDX = Expand( 'Order( Filter( TM1SubsetAll( [}Dimensions] ), [}DimensionAttributes].([}DimensionAttributes].[%sAttr_Dim%]) > %cThreshold_subsets% ), [}DimensionAttributes].([}DimensionAttributes].[%sAttr_Dim%]), Desc)');
If( SubsetExists( '}Dimensions', 'tmp' ) = 0 );
    SubsetCreate( '}Dimensions', 'tmp' );
EndIf;
SubsetMDXSet( '}Dimensions', 'tmp', sMDX );

d = 1;
While( d <= SubsetGetSize( '}Dimensions', 'tmp' ));

   vDim = SubsetGetElementName( '}Dimensions', 'tmp', d );
   TextOutput( output_filename, NumberToString( DimensionAttrN( vDim, sAttr_Dim )), vDim );
   d = d + 1;

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
