function mcb=diffrotationxyz(phi1,phi2,phi3)
mcb=[1,-phi3, phi2;
phi3, 1,-phi1;
-phi2, phi1, 1]
end