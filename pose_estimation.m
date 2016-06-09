function [transformParameters,RT,R,T,residuals,usedSensors] = ...
    pose_estimation(target_data, reference_data, minNSensors, visualise)

%
%    [transformParameters,RT,R,T,residuals,usedSensors] = ...
%                pose_estimation(target_data, reference_data, minNSensors, visualise)
%
% --------------------     
%  INPUT ARGUMENTS:
%    target_data:              <double array> 3d-matrix with the target motion data:
%                              rows: samples; 
%                              columns: markers;
%                              3rd D: X, Y, Z (,azimuth, elevation)
%                              [mandatory]
%    reference_data:           <double> 3d-matrix with the reference data:
%                              rows: one only; 
%                              columns: markers
%                              (same number of markers as in target data);
%                              3rd D: X, Y, Z (,azimuth, elevation)
%                              [mandatory]
%    minNSensors:              <double> forces a minimum of N sensors to
%                              be used for the head stabilisation (has no
%                              effect when the input data contain only
%                              two sensors)
%                              [optional]  |default = mathematical minimum = 3|
%    visualise:                <logical> flag, if set, the results will
%                              be visualised in a few figures
%                              [optional]  |default = false|
%
% --------------------     
%  OUTPUT ARGUMENTS:
%    transformParameters:      <struct array> structure with the transformation
%                              parameters. Rotation parameters are in radians. 
%    RT:                       <stuct array> estimated transformation matrix,
%                              aggregated over time (3rd dimension)
%    R:                        <struct array> estimated rotation matrix,
%                              aggregated over time (3rd dimension)
%    T:                        <double array> estimated translation vector,
%                              aggregated over time (3rd dimension)
%    residuals:                <struct array> 3d-matrix with the residuals 
%    usedSensors:              <struct array> structure containing cell
%                              arrays with the numbers of the markers/sensors
%                              that were used in the pose estimation for
%                              each sample
%     
% --------------------     
%  NOTES AND WARNINGS:
%    Warning: Input order of the markers/sensors matters! It is assumed
%    that the each column in the target and the reference data refer to
%    the same marker/sensor!
%    The transformation parameters will be calculated so that applying
%    them to the target pose will change it to the reference pose! 
%    Orientation angles as part of the target and reference pose data
%    are assumed to be in radians!
%
% --------------------     
%  GENERAL DESCRIPTION: 
%     POSE_ESTIMATION - Computes translation and rotation parameters
%                       between target and reference data
%


%      
%  $Id: pose_estimation.m,v 1.4 2010/08/20 01:47:25 chk Exp $
%  
%  Author: Christian Kroos
%  Created: 2009/03/18
%  Last Modified: $Date: 2010/08/20 01:47:25 $
%  Revision: $Revision: 1.4 $
%
%  C 2009 Christian Kroos
%   
% 

if nargin < 1
  transformParameters = [];
  R = [];
  T = [];
  help pose_estimation;
  return;
end;
if nargin < 2
  error('Check input arguments!');
end;
if nargin < 3
  minNSensors = [];
end;
if nargin < 4 || isempty(visualise)
  visualise = false;
end;
if nargin > 4
  error('Check input arguments!');
end;



if ~isempty(minNSensors) && minNSensors > size(target_data,2)
  error(['Number of sensors to be used in head stabilisation ', ...
         'cannot be greater than number of markers/sensors!'])
  
end;

MIN_NUMBER_OF_SENSORS = max([minNSensors 3]);


if size(reference_data,1) > 1
  error('Reference data cannot contain more than one observation!');
end;
if size(reference_data,2) ~= size(target_data,2)
  error(['Target and reference data must contain the same number of ' ...
         'markers!']);
end;

if size(reference_data,3) == 3
  transformParameters = struct('position',[], ...
                               'orientation',[]);
  usedSensors = struct('position',[], ...
                       'orientation',[]);
elseif size(reference_data,3) == 5
  transformParameters = struct('position',[], ...
                               'orientation',[], ...
                               'hybrid', []);
  usedSensors = struct('position',[], ...
                       'orientation',[], ...
                       'hybrid', []);
end;


if size(reference_data,2) > 2
  if size(reference_data,3) == 3
    [transformParameters.position,RT.position,R.position,T.position, ...
     residuals.position,stableData.position,usedSensors.position] = ...
        POSITION_BASED(target_data,reference_data,MIN_NUMBER_OF_SENSORS);
    if visualise
      VISULISATION(target_data,stableData.position,residuals.position, ...
                   transformParameters.position,'position',usedSensors.position)
    end;
  elseif size(reference_data,3) == 5
    [transformParameters.position,RT.position,R.position,T.position, ...
     residuals.position,stableData.position,usedSensors.position] = ...
        POSITION_BASED(target_data,reference_data,MIN_NUMBER_OF_SENSORS);
    if visualise
      VISULISATION(target_data,stableData.position,residuals.position, ...
                   transformParameters.position,'position',usedSensors.position)
    end;
    [transformParameters.orientation,RT.orientation,R.orientation, ...
     T.orientation,residuals.orientation,stableData.orientation,usedSensors.orientation] = ...
        ORIENTATION_BASED(target_data,reference_data,'normal',MIN_NUMBER_OF_SENSORS);
    if visualise
      VISULISATION(target_data,stableData.orientation,residuals.orientation, ...
                   transformParameters.orientation,'orientation',usedSensors.orientation)
    end;
    [transformParameters.hybrid,RT.hybrid,R.hybrid, ...
     T.hybrid,residuals.hybrid,stableData.hybrid,usedSensors.hybrid] = ...
        ORIENTATION_BASED(target_data,reference_data,'hybrid',MIN_NUMBER_OF_SENSORS);
    if visualise
      VISULISATION(target_data,stableData.hybrid,residuals.hybrid, ...
                   transformParameters.hybrid,'hybrid',usedSensors.hybrid)
    end;
  end;
elseif size(reference_data,2) == 2
  % two sensors only
  [transformParameters.hybrid,RT.hybrid,R.hybrid, ...
   T.hybrid,residuals.hybrid,stableData.hybrid,allUseInd] = ...
      ORIENTATION_BASED(target_data, reference_data,'two',MIN_NUMBER_OF_SENSORS);
  if visualise
    VISULISATION(target_data,stableData.hybrid,residuals.hybrid, ...
                 transformParameters.hybrid,'hybrid',allUseInd)
  end;
end;

        



% -+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-
%      subfunction POSITION_BASED
% -+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-

function  [transformPars,RT,R,T,residuals,stableData, allUseInd] = ...
    POSITION_BASED(target_data, reference_data, MIN_NUMBER_OF_SENSORS)



nSamples=size(target_data,1);

dataX = target_data(:,:,1);
dataY = target_data(:,:,2);
dataZ = target_data(:,:,3);


refDataPos = [reference_data(:,:,1); ...
              reference_data(:,:,2); ...
              reference_data(:,:,3)];

stableX = zeros(size(dataX));
stableY = zeros(size(dataY));
stableZ = zeros(size(dataZ));
R = zeros(3,3,nSamples);
T = zeros(3,1,nSamples);
RT = zeros(4,4,nSamples);
for k = 1:nSamples
  actualDataPos = [dataX(k,:); ...
                   dataY(k,:); ...
                   dataZ(k,:)];
  RT_temp = zeros(4,4);
  useInd = ENOUGH_SENSORS(actualDataPos,MIN_NUMBER_OF_SENSORS);
  allUseInd{k} = useInd;
  if isempty(useInd)
    R(:,:,k) = NaN;
    T(:,:,k) = NaN;
    % if we can't determine the rotation and translation
    % parameters, set the stable frame to NaN
    stableData{k} = cat(3,NaN,NaN,NaN);
    %fprintf('Position-based: Sample %d  excluded!\n',k);
  else  
    [R_temp,T_temp] = ESTIMATE(refDataPos(:, useInd,:), ...
                             actualDataPos(:,useInd,:));
    R(:,:,k) = R_temp;
    T(:,:,k) = T_temp;
    
    RT_temp(1:3,1:3) = R_temp;
    RT_temp(1:4,4) = [T_temp;1];
    RT(:,:,k) = RT_temp;
    
    % stabilise
    act_stable = RT_temp * [actualDataPos(:, useInd,:);ones(1,length(useInd))];
    stableData{k}= cat(3,act_stable(1,:),act_stable(2,:),act_stable(3,:));
  end;
end;


[transformPars, residuals] = ...
    EVALUATE_DECOMP(refDataPos, stableData, T, R, allUseInd, nSamples);



% -+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-
%      subfunction ORIENTATION_BASED
% -+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-

function  [transformPars,RT,R,T,residuals,stableData, allUseInd] = ...
    ORIENTATION_BASED(target_data, reference_data, kind, MIN_NUMBER_OF_SENSORS)



nSamples=size(target_data,1);

dataX = target_data(:,:,1);
dataY = target_data(:,:,2);
dataZ = target_data(:,:,3);

refDataPos=[reference_data(:,:,1); ...
            reference_data(:,:,2); ...
            reference_data(:,:,3)];

origDataAz = target_data(:,:,4);
origDataEl = target_data(:,:,5);

origRefDataAz = reference_data(:,:,4);
origRefDataEl = reference_data(:,:,5);



% in the two-sensor case the 2 sensors are either there or not (no variation
% in the number of sensors contributing to the stabilisation)
if strcmp(kind,'two')
  tempReferenceSensor = reference_data(:,2,:) - reference_data(:,1,:);
  [tempReferenceAz,tempReferenceEl,radius] = cart2sph(tempReferenceSensor(:,:,1), ...
                                                    tempReferenceSensor(:,:,2), ...
                                                    tempReferenceSensor(:,:,3));
  refTwoDataAz = [origRefDataAz tempReferenceAz];
  refTwoDataEl = [origRefDataEl tempReferenceEl];
end;



for p = 1:nSamples

  if ~strcmp(kind,'two')
    useInd = ENOUGH_SENSORS(target_data(p,:,:),MIN_NUMBER_OF_SENSORS);
  else
    useInd = ENOUGH_SENSORS(target_data(p,:,:),2);
  end;
  allUseInd{p} = useInd;

  % ---------- orientation --------------------------
  if strcmp(kind,'normal')
    if ~isempty(useInd)
      dataAz{p} = origDataAz(p,useInd);
      dataEl{p} = origDataEl(p,useInd);
      actualDataPos{p} = [dataX(p,useInd); ...
                          dataY(p,useInd); ...
                          dataZ(p,useInd)];
      refDataAz{p} = origRefDataAz(:,useInd);
      refDataEl{p} = origRefDataEl(:,useInd);
    else
      dataAz{p} = [];
      dataEl{p} = []; 
      refDataAz{p} = [];
      refDataEl{p} = []; 
    end;
  end;
  % ---------- orientation end --------------------
  
  
  % ---------- two-sensors-only ---------------------
  if strcmp(kind,'two')
    if ~isempty(useInd)    
      tempTargetSensor = target_data(p,2,:) - target_data(p,1,:);
      [tempTargetAz,tempTargetEl,radius] = cart2sph(tempTargetSensor(:,:,1), ...
                                                    tempTargetSensor(:,:,2), ...
                                                    tempTargetSensor(:,:,3));
      dataAz{p} = [origDataAz tempTargetAz];
      dataEl{p} = [origDataEl tempTargetEl];
      actualDataPos{p} = [dataX(p,useInd); ...
                          dataY(p,useInd); ...
                          dataZ(p,useInd)];
      refDataAz{p} = refTwoDataAz;
      refDataEl{p} = refTwoDataEl;
    else
      dataAz{p} = [];
      dataEl{p} = []; 
      refDataAz{p} = [];
      refDataEl{p} = []; 
    end;
  end;
  % ---------- two-sensors-only end ----------------
  
  
  % ------------- hybrid ---------------------------
  if strcmp(kind,'hybrid')
    if ~isempty(useInd)   
      centreOfGravityTarget = cat(3,mean(target_data(p,useInd,1)')', ...
                                  mean(target_data(p,useInd,2)')', ...
                                  mean(target_data(p,useInd,3)')');
      centreOfGravityRef = cat(3,mean(reference_data(:,useInd,1)')', ...
                           mean(reference_data(:,useInd,2)')', ...
                           mean(reference_data(:,useInd,3)')');
      tempAz = origDataAz(p,useInd);
      tempEl = origDataEl(p,useInd);
      tempAzRef = origRefDataAz(:,useInd);
      tempElRef = origRefDataEl(:,useInd);
      for n = 1:length(useInd)
        tempTargetSensor = target_data(p,useInd(n),1:3) - centreOfGravityTarget(:,1,:);
        [tempTargetAz,tempTargetEl,radius] = cart2sph(tempTargetSensor(:,:,1), ...
                                                      tempTargetSensor(:,:,2), ...
                                                      tempTargetSensor(:,:,3));
        tempAz = [tempAz tempTargetAz];
        tempEl = [tempEl tempTargetEl];
         
        tempReferenceSensor = reference_data(:,useInd(n),1:3) - centreOfGravityRef(:,1,:);
        [tempReferenceAz,tempReferenceEl,radius] = cart2sph(tempReferenceSensor(:,:,1), ...
                                                          tempReferenceSensor(:,:,2), ...
                                                          tempReferenceSensor(:,:,3));
        tempAzRef = [tempAzRef tempReferenceAz];
        tempElRef = [tempElRef tempReferenceEl];
       
        
        
      end;
      dataAz{p} = tempAz;
      dataEl{p} = tempEl; 
      actualDataPos{p} = [dataX(p,useInd); ...
                          dataY(p,useInd); ...
                          dataZ(p,useInd)];
      
      refDataAz{p} = tempAzRef;
      refDataEl{p} = tempElRef;   
    else
      dataAz{p} = [];
      dataEl{p} = []; 
      refDataAz{p} = [];
      refDataEl{p} = []; 
    end;
  end;
  % ------------- hybrid end -------------------
end;
  
if length(dataAz) ~= nSamples || length(dataEl) ~= nSamples
  error('Processing error!');
end;


R = zeros(3,3,nSamples);
T = zeros(3,1,nSamples);
RT = zeros(4,4,nSamples);

for k = 1:nSamples
  
  RT_temp = zeros(4,4);
  
  if isempty(dataAz{k})
    R(:,:,k) = NaN;
    T(:,:,k) = NaN;
    % if we can't determine the rotation and translation
    % parameters, set the stable frame to NaN
    stableData{k} = cat(3,NaN,NaN,NaN);
    %fprintf('Orientation-based: Sample % d excluded!\n',k);
  else 
    % ---------------------- rotation -----------------------
    % target data
    [targetUnitCircleX, targetUnitCircleY, targetUnitCircleZ] = ...
        sph2cart(dataAz{k}, dataEl{k},ones(1,size(dataAz{k},2))); 
    targetUnitCircleData = [targetUnitCircleX;targetUnitCircleY; ...
                        targetUnitCircleZ]; 
    % reference data
    [refUnitCircleX, refUnitCircleY, refUnitCircleZ] = ...
        sph2cart(refDataAz{k}, refDataEl{k}, ones(size(refDataAz{k})));
    refUnitCircleData = [refUnitCircleX;refUnitCircleY; ...
                    refUnitCircleZ];
    % estimate
    R_temp = ESTIMATE_ORIENT(refUnitCircleData,targetUnitCircleData);
    R(:,:,k) = R_temp;
    % ---------------------- rotation end -------------------
    
    % ---------------------- translation --------------------
    meanTarget = mean(actualDataPos{k},2);
    meanReference = mean(refDataPos(:,:,:),2);
    
    T_temp =  meanReference - R_temp * meanTarget;
    T(:,:,k) = T_temp;
    
    
    RT_temp(1:3,1:3) = R_temp;
    RT_temp(1:4,4) = [T_temp;1];
    RT(:,:,k) = RT_temp;
    % ---------------------- translation end ----------------
    
    % ---------------------- stabilisation ------------------
    % only for evaluation purposes
    act_stable = RT_temp * [actualDataPos{k};ones(1,size(actualDataPos{k},2))];
    stableData{k} = cat(3,act_stable(1,:),act_stable(2,:),act_stable(3,:));
     % ---------------------- stabilisation end --------------
  end;
end;


[transformPars, residuals] = ...
    EVALUATE_DECOMP(refDataPos, stableData, T, R, allUseInd,nSamples);




% -+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-
%      subfunction ESTIMATE
% -+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-


function [R,T] = ESTIMATE(refPose,actPose);


sizeAct=size(actPose,2);
sizeRef=size(refPose,2);

% determine orientation
actPoseMean = mean(actPose')';
refPoseMean = mean(refPose')';
P = (refPose - refPoseMean*ones(sizeAct,1)') * ...
    (actPose - actPoseMean*ones(sizeRef,1)')';
[V,S,U] = svd(P);
S = eye(3,3);
S(3,3) = det(V * U');
R = V * S * U';
% determine translation
T = refPoseMean - R * actPoseMean;



% -+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-
%      subfunction ESTIMATE_ORIENT
% -+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-


function R = ESTIMATE_ORIENT(refPose,actPose)

% determine orientation
P = refPose * actPose';
[V,S,U] = svd(P);
S = eye(3,3);
S(3,3) = det(V * U');
R = V * S * U';




% -+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-
%      subfunction  EVALUATE_DECOMP
% -+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-


function [transformPars, residuals] = ...
    EVALUATE_DECOMP(refDataPos,stableData,T,R,allUseInd,nSamples);


transformPars = struct('transX',[], ...
                       'transY',[], ...
                       'transZ',[], ...
                       'rotX',[], ...
                       'rotY',[], ...
                       'rotZ',[]);


residDim = zeros(nSamples,size(refDataPos,2),3) * NaN;
residEucl = zeros(nSamples,size(refDataPos,2)) * NaN;
for k = 1:nSamples
  stableX = stableData{k}(:,:,1);
  stableY = stableData{k}(:,:,2);
  stableZ = stableData{k}(:,:,3);
  % residuals
  if ~isempty(allUseInd{k})
    residX = stableX - refDataPos(1,allUseInd{k});
    residY = stableY - refDataPos(2,allUseInd{k});
    residZ = stableZ - refDataPos(3,allUseInd{k});
    residDim(k,allUseInd{k},1:3) = cat(3,residX,residY,residZ);
    residEucl(k,allUseInd{k}) = sqrt(residX.^2 + residY.^2 + residZ.^2);
  end;
end;

residuals.dimensions = residDim;
residuals.euclidean = residEucl;

%-------------------------------------------
% from http://www.codeguru.com/forum/archive/index.php/t-329530.html
% jkotwas 
% June 2nd, 2005, 09:48 AM For a homogeneous geometrical
% transformation matrix, you can get the roll, pitch and yaw angles,
% following the TRPY convention, using the following formulas:
%
% roll (rotation around z) : atan2(xy, xx)
% pitch (rotation around y) : -arcsin(xz)
% yaw (rotation around x) : atan2(yz,zz)
%
% where the matrix is defined in the form:
%
% [
% xx, yx, zx, px;
% xy, yy, zy, py;
% xz, yz, zz, pz;
% 0, 0, 0, 1
% ]
%
% Do use the full atan2 function so that you can get values from full
% trigonometric circle (ie. don't just use atan).
%------------------------------------------------------

transX = squeeze(T(1,1,:));
transY = squeeze(T(2,1,:));
transZ = squeeze(T(3,1,:));
rotX = squeeze(atan2(R(3,2,:),R(3,3,:)));
rotY = squeeze(-asin(R(3,1,:)));
rotZ = squeeze(atan2(R(2,1,:),R(1,1,:)));

for p = 1:nSamples
  transformPars(p).transX = transX(p);
  transformPars(p).transY = transY(p);
  transformPars(p).transZ = transZ(p);
  transformPars(p).rotX = rotX(p);
  transformPars(p).rotY = rotY(p);
  transformPars(p).rotZ = rotZ(p);
end;


% -+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-
%      subfunction ENOUGH_SENSORS
% -+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-

function useInd = ENOUGH_SENSORS(data_frame, minNumberOfSensors)


if size(data_frame,1) == 1
  useInd = find(~(sum(isnan(data_frame),3)));
elseif size(data_frame,3) == 1
  useInd = find(~(sum(isnan(data_frame))));
else
  error('Wrong format of data frame!');
end;

% return empty useInd if not enough sensors are available
if length(useInd) < minNumberOfSensors
  useInd = [];
end;


% -+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-
%      subfunction VISUALISATION
% -+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-.-+-

function VISULISATION(target_data,stableData,residuals, ...
                      transformParameters,type,allUseInd) 



windowPos = [50 57 563 621];
if strcmp(type,'orientation')
  windowPos(1) =  windowPos(1) + windowPos(3)*2;
end;
if strcmp(type,'hybrid')
  windowPos(1) =  windowPos(1) + windowPos(3);
end;


% differences
sta = zeros(size(target_data,1),size(target_data,2),3) * NaN;
for k = 1:length(stableData)
  if ~isempty(allUseInd{k})
    sta(k,allUseInd{k},:) = stableData{k};
  end;
end;
  
xd=sta(:,:,1)-target_data(:,:,1);
yd=sta(:,:,2)-target_data(:,:,2);
zd=sta(:,:,3)-target_data(:,:,3);

fh1 = figure('unit','pixel', ...
           'position',windowPos, ...
           'numbertitle','off', ...
           'name',['Pose differences - based on ' type]);
subplot(3,1,1)
lh = line(1:size(xd,1),xd,'color','r');
ylabel('diff');
xlabel('X');
grid on;
subplot(3,1,2)
lh = line(1:size(yd,1),yd,'color','b');  
ylabel('diff');
xlabel('Y');
grid on;
subplot(3,1,3)
lh = line(1:size(zd,1),zd,'color',[0 0.7 0]); 
ylabel('diff');
xlabel('Z');
grid on;

% residuals
fh2 = figure('unit','pixel', ...
           'position',windowPos, ...
           'numbertitle','off', ...
           'name',['Pose residuals - based on ' type]);
subplot(4,1,1)
lh = line(1:size(residuals.dimensions,1),residuals.dimensions(:,:,1),'color','r'); 
ylabel('residual');
xlabel('X');
grid on;
subplot(4,1,2)
lh = line(1:size(residuals.dimensions,1),residuals.dimensions(:,:,2),'color','b'); 
ylabel('residual');
xlabel('Y');
grid on;
subplot(4,1,3)
lh = line(1:size(residuals.dimensions,1),residuals.dimensions(:,:,3),'color',[0 0.7 0]); 
ylabel('residual');
xlabel('Z');
grid on;
subplot(4,1,4)
% check below
lh = line(1:size(residuals.euclidean,1),residuals.euclidean,'color','k'); 
ylabel('residual');
xlabel('Euclidean');
grid on;


% translation
tn = length(transformParameters);
fh3 = figure('unit','pixel', ...
           'position',windowPos, ...
           'numbertitle','off', ...
           'name',['Translation - based on ' type]);
subplot(3,1,1)
lh = line(1:tn,cat(1,transformParameters.transX),'color','r', ...
          'marker','o');  
ylabel('input unit');
xlabel('X');
grid on;
subplot(3,1,2) 
lh = line(1:tn,cat(1,transformParameters.transY),'color','b', ...
          'marker','o'); 
ylabel('input unit');
xlabel('Y');
grid on;
subplot(3,1,3)
lh = line(1:tn,cat(1,transformParameters.transZ),'color',[0 0.7 0], ...
          'marker','o'); 
ylabel('input unit');
xlabel('Z');
grid on;

% rotation 
rn = length(transformParameters);
fh4 = figure('unit','pixel', ...
           'position',windowPos, ...
           'numbertitle','off', ...
           'name',['Rotation - based on ' type]);
subplot(3,1,1)
lh = line(1:rn,cat(1,transformParameters.rotX)/pi*180,'color','r', ...
          'marker','o'); 
ylabel('degree');
xlabel('yaw - around X');
grid on;
subplot(3,1,2)
lh = line(1:rn,cat(1,transformParameters.rotY)/pi*180,'color','b', ...
          'marker','o'); 
ylabel('degree');
xlabel('pitch - around Y');
grid on;
subplot(3,1,3)
lh = line(1:rn,cat(1,transformParameters.rotZ)/pi*180,'color',[0 0.7 0], ...
          'marker','o'); 
ylabel('degree');
xlabel('roll - around Z');
grid on;

drawnow;
