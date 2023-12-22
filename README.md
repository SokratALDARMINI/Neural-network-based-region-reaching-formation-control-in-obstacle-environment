# Neural network-based region reaching formation control in an obstacle environment
This MATLAB program is done as a verification of the main results that are shown in the work "Yu, Jinwei, et al. "Neural network-based region reaching formation control for multi-robot systems in obstacle environment." Neurocomputing 333 (2019): 11-21.".

The studied problem is formation control in an obstacle environment. The main task to be solved is to achieve a collision-avoiding, obstacle-avoiding, region-reaching formation of a multiagent system considering the existence of bounded disturbances and uncertainty in the agents’ models.

The proposed solution uses a combination of different tools which are:

•	Potential functions to achieve the region reaching and obstacle and collision avoidance.

•	RBF neural network to learn the unknown dynamic of the agents.

•	Robust compensator to eliminate the effect of uncertainties and external disturbances.

•	 Adaptive control gains with dynamic adaptation laws to adjust the weight of the control task.

 For more information, the user can check the exact meaning of the simulation parameters in the mentioned work.

Simulink components are as follows: 

Total simulink system:
![image](https://github.com/SokratALDARMINI/Neural-network-based-region-reaching-formation-control-in-obstacle-environment/assets/95107709/2172fa34-b161-45bf-841d-55cdd709374e)

Agent Model:
![image](https://github.com/SokratALDARMINI/Neural-network-based-region-reaching-formation-control-in-obstacle-environment/assets/95107709/6150a9d9-43c7-4140-aa87-2240627273bf)

Repulsive force for an agent (first), and Collision and obstacle avoidance function (second)
![image](https://github.com/SokratALDARMINI/Neural-network-based-region-reaching-formation-control-in-obstacle-environment/assets/95107709/b5fac168-9cac-4ea1-ac4e-23283092cad1)

Attractive force for an agent:
![image](https://github.com/SokratALDARMINI/Neural-network-based-region-reaching-formation-control-in-obstacle-environment/assets/95107709/16c66822-d0f5-44b6-b932-046b025a7e52)

Consensus law and its derivative:
![image](https://github.com/SokratALDARMINI/Neural-network-based-region-reaching-formation-control-in-obstacle-environment/assets/95107709/8c66bc8d-cf0f-4d0d-816e-c2723925e0b2)

Alpha adaptive law for an agent:
![image](https://github.com/SokratALDARMINI/Neural-network-based-region-reaching-formation-control-in-obstacle-environment/assets/95107709/3191bdc2-8849-4856-a0f4-68904bc6833a)

Beta adaptive law for an agent:
![image](https://github.com/SokratALDARMINI/Neural-network-based-region-reaching-formation-control-in-obstacle-environment/assets/95107709/e0d55232-1fba-468b-b0f6-ba4a618238dd)

s and x signal for an agent:
![image](https://github.com/SokratALDARMINI/Neural-network-based-region-reaching-formation-control-in-obstacle-environment/assets/95107709/3cc9ec25-d0f0-4d54-9c1a-9de300e3121c)

Compensator for an agent:
![image](https://github.com/SokratALDARMINI/Neural-network-based-region-reaching-formation-control-in-obstacle-environment/assets/95107709/6b9e0b1c-5c72-4b48-9ccf-8f152c257979)

Adaptive law for weights for an agent:
![image](https://github.com/SokratALDARMINI/Neural-network-based-region-reaching-formation-control-in-obstacle-environment/assets/95107709/1db78b69-7f44-4c38-a27a-6c74a718a492)












