% Matlab script that helps to select the proper feedback values for the
% LDOs and BUCK regulators

clear all;
clc;

% Resistor values available on DigiKey on 2/7/2011
r = [
102e3
105e3
107e3
110e3
113e3
115e3
118e3
120e3
121e3
124e3
127e3
130e3
133e3
137e3
140e3
143e3
147e3
150e3
154e3
158e3
160e3
162e3
165e3
169e3
174e3
178e3
180e3
182e3
187e3
191e3
196e3
200e3
205e3
210e3
215e3
220e3
221e3
226e3
232e3
237e3
240e3
243e3
249e3
255e3
261e3
267e3
270e3
274e3
280e3
287e3
294e3
300e3
301e3
309e3
316e3
324e3
330e3
332e3
340e3
348e3
357e3
360e3
365e3
374e3
383e3
390e3
392e3
402e3
412e3
422e3
430e3
432e3
442e3
453e3
464e3
470e3
475e3
487e3
499e3
510e3
511e3
523e3
536e3
549e3
560e3
562e3
576e3
590e3
604e3
619e3
620e3
634e3
649e3
665e3
680e3
681e3
698e3
715e3
732e3
750e3
768e3
787e3
806e3
820e3
825e3
845e3
866e3
887e3
909e3
910e3
931e3
953e3
976e3
1e6
1.02e6
1.05e6
1.07e6
1.1e6
];

% Specify parameters here
V = 3.3; % required output voltage [V]
t = 0.02; % output voltage tolerance [%]
p = [];
q = [];

t = t/100;

for ii = 1 : length(r)
%     for jj = 1 : length(r)
        R1 = r(ii);
%         R2 = r(jj);
        R2 = 160e3;
        Vf = 0.8*(1+R1/R2);
        if abs(V-Vf) < V*t
%             disp(Vf-V)
            p = [p ; [R1 R2]];
            q = [q ; [Vf V Vf-V (Vf-V)/V*100]];
        end
%     end
end

p;
q;
s = [p q]
