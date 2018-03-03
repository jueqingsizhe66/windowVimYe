# Session file started:  2016/12/14 01:00:12
# CFX-17.0 build 2015.11.13-23.37-135321

# To avoid unnecessary file pre-processing and modifications, include
# COMMAND FILE at the top of your session file.
# If it is not included, the file is assumed to be older and will be
# modified for backward compatibility.
COMMAND FILE:
  CFX Post Version = 17.0
END


## 文件夹设置
!@processDir=("L:\\NacelleYaw");
!$resultDir="result";
!$resultCpDir="result\\CpNew"; ## save the result into result folders
!$resultContourDir="result\\Contour"; ## save the result into result folders
#!@yawAngles=(45);

## 几何设置
!$R_blade = 5.029;
!$R = $R_blade;
!$pi = 3.1415926;
!$periodic = 60/$rotationRate;

## 来流风速设置
!$windSpeed = 7;


## 运动设置
### 旋转轴设置
!$rotationRate = 71.9;
### 偏航轴设置
!$startTime=26.703776 ;
!$yawRotateSpeed=5;
###  偏摆轴设置
!$pitchRotateSpeed=1.6666667  ;   ## 10du /6s

## Global variable
!$length=@processDir; #get the length of the processDir array
!for($count=0;$count<$length;$count++){

## get the current Directory
!$pathDir=$processDir[$count];
!$outputDir = "${pathDir}\\${resultDir}";
!$outputCpDir = "${pathDir}\\${resultCpDir}";
!mkdir $outputDir;
!mkdir $outputCpDir; ## create the outputDir;
#!mkdir $outputContourPressureDir; ## create the outputDir;
#!mkdir $outputContourVelocityDir; ## create the outputDir;
## get the current Directory's yaw Angle
#!$yawAngle = $yawAngles[$count];


#!$segement  = $timeRotor/$calculateTimeStep;
#!for($j =1; $j<=$numberStep; $j++){
#    !$currentFileStep = $initStep+($j-1)*$saveTimeStep;
#    !$currentFilename = "$pathDir\\${currentFileStep}_full.trn";
#    !$currentTime     = $initTime + ($j - 1)*$saveTimeStep*$segement;
!opendir(TMP,$pathDir)||die "can not open $!";

!@files=grep(/sphere.*dat/,readdir TMP); ###*****************文件过滤设置*****###

#!@files=grep(/trn/,readdir TMP);
!foreach $file(@files){
#!print "${pathDir}\\$a." newB\n";
#!$timestep=substr($file,-length($file),)
!$currentFilename = "${pathDir}//${file}";
!@filesd = split(/[-|.]/,${file});
!$timeStep = $filesd[4];
    
DATA READER:
  
  Clear All Objects = false
  Append Results = false
  Edit Case Names = false
  Open to Compare = false
  Multi Configuration File Load Option = Last Case
  Open in New View = true
  Keep Camera Position = true
  Load Particle Tracks = true
  Files to Compare =
  Construct Variables From Fourier Coefficients = True
END

DATA READER:
  Domains to Load = sphere,far_field,cylinder, windrotor
END

#! $filePath = getValue("DATA READER","Current Results File");

#! print "\nFor $filePath\n";

#> load filename= $filePath, force_reload=true
> load filename= $currentFilename, force_reload=true

#LIBRARY:
#    CEL:
#        EXPRESSIONS:
#            $currentTime = Time
#        END
#    END
#END
#EXPRESSION EVALUATOR:
#  Evaluated Expression = $currentTime
#END

#!print("CurrentTime= $currentTime");
# Session file stopped:  2016/12/14 01:00:29
#!$currentTime = 18.2429;

!$currentTime =getValue( "DATA READER", "Current Timevalue"); 
#!$angle = ($currentTime - int($currentTime/$periodic)*$periodic)/$periodic*360;
#Take care -10!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#!$angle =( ($currentTime - int($currentTime/$periodic)*$periodic)/$periodic*360 ); 
#!$anglePi =( ($currentTime - int($currentTime/$periodic)*$periodic)/$periodic*360)*3.1415926/180; 

!$zhouqi=$currentTime/$periodic;
#### 旋转角度
#!$angle =(($zhouqi-int($zhouqi))*360); 

#!print "Ye: $periodic, $currentTime, $currentTime/$periodic, $zhouqi int($zhouqi)\n";
!$anglePi =(($zhouqi-int($zhouqi))*360)*3.1415926/180; 

#### 偏航角度
!$yawAngle = (($currentTime-$startTime)*$yawRotateSpeed); 
!$yawAnglePi = (($currentTime-$startTime)*$yawRotateSpeed)*3.1416926/180.0; 

####  偏摆角度
!$pitchAngle = (($currentTime-$startTime)*$pitchRotateSpeed); 
!$pitchAnglePi = (($currentTime-$startTime)*$pitchRotateSpeed)*3.1416926/180.0; 


####  初始位置
!$initialX=0;
!$initialY=5.029;
!$initialZ=0;



!$normal_x=$initialY*( cos($pitchAnglePi)*sin($anglePi) + sin($pitchAnglePi)*sin($yawAnglePi)*cos($anglePi)); 
!$normal_y=$initialY*cos($anglePi)*cos($yawAnglePi); 
!$normal_z=$initialY*(-sin($pitchAnglePi)*sin($anglePi) + cos($pitchAnglePi)*sin($yawAnglePi)*cos($anglePi)); 

#!$normal_x =cos($angle*$pi/180);
#!$normal_y =sin($angle*$pi/180);
!print("normal_x $normal_x  normal_y $normal_y normal_z $normal_z\n");

#! @cutPlanes = (0.3, 0.47, 0.63, 0.8, 0.95);
!@cutPlanes = (0.15,0.2,0.25,0.3,0.35,0.4,0.47,0.5, 0.55,0.6,0.63,0.65,0.7,0.75,0.8,0.85,0.9,0.95);
!$planeLength=@cutPlanes;
!for ($i=0; $i<$planeLength; $i++) {
!$cutPlane = $cutPlanes[$i];
!$cutPosition =  $cutPlane*$R;
!print("cutPosition = $cutPosition \n");
#!$x =$cutPosition*$normal_x;
#!$y =$cutPosition*$normal_y;

!$x=$initialY*$cutPlane*cos($yawAnglePi)*sin($anglePi);
!$y=$initialY*$cutPlane*cos($anglePi);
!$z=-$initialY*$cutPlane*sin($yawAnglePi)*sin($anglePi);

!print("x $x  y $y  z $z\n");
# !$horVel  =( $windSpeed*cos($yawAngle*$pi/180))**2;
# # !print("horVel = $horVel \n");
# !$verVel = ( $rotationRate/60*2*$pi*$cutPosition -$windSpeed*sin($yawAngle*$pi/180))**2;
# #!print("verVel = $verVel \n");
# !$finalVel = $horVel + $verVel;
# !$pressureCp = "Pressure/(0.5*Density*$finalVel)";
# !print("$pressureCp\n");
!$PlaneName = "PlaneName $i";
!$LocationPlaneName = "/PLANE:PlaneName $i";
!$PolyLineName = "Polyline $i";
!$LocationPolyLineName = "/POLYLINE:Polyline $i";
!$ChartName= "Chart $i";
!$LocationChartName= "Chart $i";

# !$tempCp="cp${i}";
# LIBRARY:
#   CEL:
#     EXPRESSIONS:
#       $tempCp = $pressureCp
#     END
#   END
# END
#
# EXPRESSION EVALUATOR:
#   Evaluated Expression = $tempCp
# END
#
# > forceupdate EXPRESSION EVALUATOR

# !$VariableName ="Variable $i";
# USER SCALAR VARIABLE:$VariableName
#   Boundary Values = Conservative
#   Calculate Global Range = Off
#   Expression = $tempCp
#   Recipe = Expression
#   Variable to Copy = Pressure
#   Variable to Gradient = Pressure
# END
#

      #cor2 = -X*cos(${angle}*${pi}/180)+Y*sin(${angle}*${pi}/180)
LIBRARY:
  CEL:
    EXPRESSIONS:
      cor2 = -X*cos($anglePi)*cos($yawAnglePi)+Y*cos($yawAnglePi)*sin($anglePi)-Z*sin($yawAnglePi)
    END
  END
END

EXPRESSION EVALUATOR:
  Evaluated Expression = cor2
END

> forceupdate EXPRESSION EVALUATOR

USER SCALAR VARIABLE:CoordinateSelf
  Boundary Values = Conservative
  Calculate Global Range = Off
  Expression = cor2
  Recipe = Expression
  Variable to Copy = Pressure
  Variable to Gradient = Pressure
END


PLANE:$PlaneName
  Apply Instancing Transform = On
  Apply Texture = Off
  Blend Texture = On
  Bound Radius = 0.5 [m]
  Colour = 0.75, 0.75, 0.75
  Colour Map = Default Colour Map
  Colour Mode = Constant
  Colour Scale = Linear
  Colour Variable = Pressure
  Colour Variable Boundary Values = Conservative
  Culling Mode = No Culling
  Direction 1 Bound = 1.0 [m]
  Direction 1 Orientation = 0 [degree]
  Direction 1 Points = 10
  Direction 2 Bound = 1.0 [m]
  Direction 2 Points = 10
  Domain List = windrotor
  Draw Faces = On
  Draw Lines = Off
  Instancing Transform = /DEFAULT INSTANCE TRANSFORM:Default Transform
  Invert Plane Bound = Off
  Lighting = On
  Line Colour = 0, 0, 0
  Line Colour Mode = Default
  Line Width = 1
  Max = 0.0 [Pa]
  Min = 0.0 [Pa]
  Normal = $normal_x , $normal_y , $normal_z
  Option = Point and Normal
  Plane Bound = None
  Plane Type = Slice
  Point = $x [m], $y [m], $z [m]
  Point 1 = 0 [m], 0 [m], 0 [m]
  Point 2 = 1 [m], 0 [m], 0 [m]
  Point 3 = 0 [m], 1 [m], 0 [m]
  Range = Global
  Render Edge Angle = 0 [degree]
  Specular Lighting = On
  Surface Drawing = Smooth Shading
  Texture Angle = 0
  Texture Direction = 0 , 1 , 0
  Texture File =
  Texture Material = Metal
  Texture Position = 0 , 0
  Texture Scale = 1
  Texture Type = Predefined
  Tile Texture = Off
  Transform Texture = Off
  Transparency = 0.0
  X = 0.0 [m]
  Y = 0.0 [m]
  Z = 0.0 [m]
  OBJECT VIEW TRANSFORM:
    Apply Reflection = Off
    Apply Rotation = Off
    Apply Scale = Off
    Apply Translation = Off
    Principal Axis = Z
    Reflection Plane Option = XY Plane
    Rotation Angle = 0.0 [degree]
    Rotation Axis From = 0 [m], 0 [m], 0 [m]
    Rotation Axis To = 0 [m], 0 [m], 0 [m]
    Rotation Axis Type = Principal Axis
    Scale Vector = 1 , 1 , 1
    Translation Vector = 0 [m], 0 [m], 0 [m]
    X = 0.0 [m]
    Y = 0.0 [m]
    Z = 0.0 [m]
  END
END

POLYLINE:$PolyLineName
  Apply Instancing Transform = On
  Boundary List = blade2
  Colour = 0, 1, 0
  Colour Map = Default Colour Map
  Colour Mode = Constant
  Colour Scale = Linear
  Colour Variable = Pressure
  Colour Variable Boundary Values = Conservative
  Contour Level = 1
  Domain List = windrotor
  Input File =
  Instancing Transform = /DEFAULT INSTANCE TRANSFORM:Default Transform
  Line Width = 2
  Location = $LocationPlaneName
  Max = 0.0
  Min = 0.0
  Option = Boundary Intersection
  Range = Global
  OBJECT VIEW TRANSFORM:
    Apply Reflection = Off
    Apply Rotation = Off
    Apply Scale = Off
    Apply Translation = Off
    Principal Axis = Z
    Reflection Plane Option = XY Plane
    Rotation Angle = 0.0 [degree]
    Rotation Axis From = 0 [m], 0 [m], 0 [m]
    Rotation Axis To = 0 [m], 0 [m], 0 [m]
    Rotation Axis Type = Principal Axis
    Scale Vector = 1 , 1 , 1
    Translation Vector = 0 [m], 0 [m], 0 [m]
    X = 0.0 [m]
    Y = 0.0 [m]
    Z = 0.0 [m]
  END
END



CHART:$ChartName
  Chart Axes Font = Tahoma, 10, False, False, False, False
  Chart Axes Titles Font = Tahoma, 10, True, False, False, False
  Chart Grid Line Width = 1
  Chart Horizontal Grid = On
  Chart Legend = On
  Chart Legend Font = Tahoma, 8, False, False, False, False
  Chart Legend Inside = Outside Chart
  Chart Legend Justification = Center
  Chart Legend Position = Bottom
  Chart Legend Width Height = 0.2 , 0.4
  Chart Legend X Justification = Right
  Chart Legend XY Position = 0.73 , 0.275
  Chart Legend Y Justification = Center
  Chart Line Width = 2
  Chart Lines Order = Series 1,Chart Line 1
  Chart Minor Grid = Off
  Chart Minor Grid Line Width = 1
  Chart Symbol Size = 4
  Chart Title = Title
  Chart Title Font = Tahoma, 12, True, False, False, False
  Chart Title Visibility = On
  Chart Type = XY
  Chart Vertical Grid = On
  Chart X Axis Automatic Number Formatting = On
  Chart X Axis Label = X Axis <units>
  Chart X Axis Number Format = %10.3e
  Chart Y Axis Automatic Number Formatting = On
  Chart Y Axis Label = Y Axis <units>
  Chart Y Axis Number Format = %10.3e
  Default Chart X Variable = Y
  Default Chart Y Variable = Pressure
  Default Histogram Y Axis Weighting = None
  Default Time Chart Variable = Pressure
  Default Time Chart X Expression = Time
  Default Time Variable Absolute Value = Off
  Default Time Variable Boundary Values = Conservative
  Default X Variable Absolute Value = Off
  Default X Variable Boundary Values = Conservative
  Default Y Variable Absolute Value = Off
  Default Y Variable Boundary Values = Conservative
  FFT Full Input Range = On
  FFT Max = 0.0
  FFT Min = 0.0
  FFT Subtract Mean = Off
  FFT Window Type = Hanning
  FFT X Function = Frequency
  FFT Y Function = Power Spectral Density
  Histogram Automatic Divisions = Automatic
  Histogram Divisions = -1.0,1.0
  Histogram Divisions Count = 10
  Histogram Y Axis Value = Count
  Is FFT Chart = Off
  Max X = 1.0
  Max Y = 1.0
  Min X = -1.0
  Min Y = -1.0
  Time Chart Keep Single Case = Off
  Use Data For X Axis Labels = On
  Use Data For Y Axis Labels = On
  X Axis Automatic Range = On
  X Axis Inverted = Off
  X Axis Logarithmic Scaling = Off
  Y Axis Automatic Range = On
  Y Axis Inverted = Off
  Y Axis Logarithmic Scaling = Off
  CHART SERIES:Series 1
    Chart Line Custom Data Selection = Off
    Chart Line Filename =
    Chart Series Type = Regular
    Chart X Variable = Chart Count
    Chart Y Variable = Eddy Viscosity
    Histogram Y Axis Weighting = None
    Location = $LocationPolyLineName
    Monitor Data Filename =
    Monitor Data Source = Case
    Monitor Data X Variable Absolute Value = Off
    Monitor Data Y Variable Absolute Value = Off
    Series Name = Series 1
    Time Chart Expression = Time
    Time Chart Type = Point
    Time Chart Variable = Eddy Viscosity
    Time Chart X Expression = Time
    Time Variable Absolute Value = Off
    Time Variable Boundary Values = Conservative
    X Variable Absolute Value = Off
    X Variable Boundary Values = Conservative
    Y Variable Absolute Value = Off
    Y Variable Boundary Values = Conservative
    CHART LINE:Chart Line 1
      Auto Chart Line Colour = On
      Chart Line Colour = 1.0, 0.0, 0.0
      Chart Line Style = Automatic
      Chart Line Visibility = On
      Chart Symbol Colour = 0.0, 1.0, 0.0
      Chart Symbol Style = None
      Fill Area = On
      Fill Area Options = Automatic
      Is Valid = True
      Line Name = Series 1
      Use Automatic Line Naming = On
    END
  END
  OBJECT REPORT OPTIONS:
    Report Caption =
  END
END

#>show $LocationPolyLineName, view=/VIEW:View 1
>hide $LocationPolyLineName, view=/VIEW:View 1


!$cutPlanePecentage = $cutPlanes[$i]*100;
!$saveChartName = "$outputCpDir//chart_".sprintf("%.3f",$yawAngle)."_${timeStep}_${cutPlanePecentage}%.png";
!$saveExcelName = "$outputCpDir//excel_".sprintf("%.3f",$yawAngle)."_${timeStep}_${cutPlanePecentage}%.csv";


>chart print, Chart Name = $ChartName, filename = $saveChartName, x size = 800, y \
size = 800, format = png, factor = 0.930986

EXPORT:
  ANSYS Export Data = Element Heat Flux
  ANSYS File Format = ANSYS
  ANSYS Reference Temperature = 0.0 [K]
  ANSYS Specify Reference Temperature = Off
  ANSYS Supplemental HTC = 0.0 [W m^-2 K^-1]
  Additional Variable List =
  BC Profile Type = Inlet Velocity
  Export Connectivity = Off
  Export Coord Frame       = Global
  Export File              = $saveExcelName
  Export Geometry          = On
  Export Location Aliases  =
  Export Node Numbers      = Off
  Export Null Data         = On
  Export Type              = Generic
  Export Units System      = Current
  Export Variable Type     = Current
  External Export Data     = None
  Include File Information = Off
  Include Header           = On
  Location                 = BLADE1
  Location List            = $LocationPolyLineName
  Null Token               = null
  Overwrite                = On
  Precision                = 8
  Separator                = ", "
  Spatial Variables        = X,Y,Z
  Variable List            = CoordinateSelf,Pressure
  Vector Brackets          = ()
  Vector Display           = Scalar
END
>export

## cutPlane
###  cut plane  ,then plot the contour
>hide /WIREFRAME:Wireframe, view=/VIEW:View 1

#!if($i>0){

##  cut plane Improve
#!$lastPlane=${i}-1;
#!$LastLocationPlaneName = "/PLANE: PlaneName ${lastPlane}";
#>hide ${LastLocationPlaneName}, view=/VIEW:View 1
#!}
>show ${LocationPlaneName}, view=/VIEW:View 1

!}
!}

!closedir TMP;
!}
