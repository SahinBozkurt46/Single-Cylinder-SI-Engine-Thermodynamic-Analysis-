%% Şahin Utku Bozkurt   030170161   HW-2
%% Calculating and drawing the ideal air standard cycle of Single cylinder SI engine

% Given engine parameters
bore = 0.085; % m
stroke = 0.090; % m
CR = 12; % Compression Ratio
LHV = 49*10^6; %J/kg
stoich_air = 17; % 
rpm = 1501.5; % Revolutions per minute
lambda = 0.91; % Air-fuel ratio
moment = 25.11; % Nm
Vd=pi*0.25*bore^2*stroke;%m^3
advance = 7; % degrees 
water_flow=2.92*10^-4 ;% m3/s, water flow
mfc = 1.097/3600; % kg/s, mean fuel consumption
m_fuel = mfc; % kg/s, mass flow rate of fuel
m_water=0.291; % kg/s,mass of water flow 
m_air=17.56/3600 ; % kg/s, mass of air flow 
T_diff = 30; % K, temperature difference of cooling water
T_manifold = 353; % K, temperature of intake manifold
T_atmos = 298; % K, temperature of ambient air
T_exhaust=777.9; % K, temperature of ambient air
c_v_water=4190; % J/(kg*°C)
c_v_air=1006; % J/(kg*°C)
displacement=stroke;


% Constants
R = 287; % J/kg-K, gas constant of air
k = 1.3; % Specific heat ratio of air

% Initial conditions
P1 = 10e5; % Pa
T1 = T_atmos; % K
Vc=Vd/(CR-1);% m3
V1=Vd+Vc;% m3
V1 = (pi/4) * bore^2 * stroke; % m3


% Process 1-2: Isentropic compression
V2 = V1/CR;
P2 = P1 * (V1/V2)^k;
T2 = T1 * (V1/V2)^(k-1);

% Process 2-3: Constant volume heat addition
Q_in = LHV * m_fuel;
T3 = T2+((Q_in)/((m_air+m_fuel)*c_v_air));
P3 = P2 * (T3/T2);
V3=V2;

% Process 3-4: Isentropic expansion
V4 = V1;
P4 = P3/(CR^k);
T4=T3/(CR^(k-1));

% Process 4-1: Constant volume heat rejection
Q_out_water = m_water * c_v_water * (71.6-67.8);
Q_out_air = (m_air+m_fuel) * c_v_air * (T_exhaust-T_manifold);
Q_out=Q_out_air+Q_out_water;


% Plotting the cycle
V = [V1 V2 V3 V4 V1];
P = [P1 P2 P3 P4 P1];

plot(V,P,'-o');
xlabel('Volume (m^3)');
ylabel('Pressure (Pa)');
title('Ideal air standard cycle for Single cylinder SI engine');


% Calculate effective power
effective_power = moment *(2*pi*rpm/60);

% Calculate brake specific fuel consumption
bsfc = (m_fuel*3600 / effective_power)*10^6;% g/kWh

% Calculate effective efficiency
effective_efficiency = effective_power*10^6 /(bsfc*LHV);

%Indicated Power
ipow=Q_in-Q_out;% W

% Calculate indicated mean effective pressure (IMEP)
imep = (ipow/(Vd*(rpm/60)*0.5))/1000;% kPa

% Calculate brake mean effective pressure (BMEP)
bmep = (effective_power/(Vd*(rpm/60)*0.5))/1000;% kPa

% Calculate friction mean effective pressure (FMEP)
fmep = bmep - imep;

% Calculate mechanical efficiency
mechanical_efficiency = bmep/imep;

% Calculate volumetric efficiency
volumetric_efficiency=(2*m_air/((rpm/60)*Vd));

% Calculate energy lost (Qfriction)
Q_out_friction=Q_in-Q_out-effective_power;

% Display results
fprintf('Effective power: %f W\n', effective_power);
fprintf('BSFC: %f g/Wh\n', bsfc);
fprintf('Effective efficiency: %f %%\n', effective_efficiency*100);
fprintf('IMEP: %f kPa\n', imep);
fprintf('BMEP: %f kPa\n', bmep);
fprintf('FMEP: %f kPa\n', fmep);
fprintf('Mechanical efficiency: %f %% ', (mechanical_efficiency*100));
fprintf('\nVolumetric efficiency: %f %% ', (volumetric_efficiency*100));
fprintf('\nrate of energy lost(Qfriction) %f %  ', (Q_out_friction*100/Q_in));
fprintf('\nrate of heat rejected with exhaust gas  %f %  ', (Q_out_air*100/Q_in));
fprintf('\nrate of heat rejected with cooling water  %f %  ', (Q_out_water*100/Q_in));

%% Drawing the real cycle of single cylinder SI engine

v_values=readmatrix('1500_7_90_1732_Şahin Utku Bozkurt.xlsx','Range','B2:B721');  % L
p_values=readmatrix('1500_7_90_1732_Şahin Utku Bozkurt.xlsx','Range','C2:C721');  % bar


plot(v_values/1000,p_values);
title('P-V Diagram');
ylabel('Pressure(bar)');
xlabel('Volume(m3)');
grid

