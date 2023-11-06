
function rotateCoords (x,y,z,rX,rY,rZ)
	local cosX = math.cos(rX);
	local cosY = math.cos(rY);
	local cosZ = math.cos(rZ);
	local six = math.sin(rX);
	local siy = math.sin(rY);
	local siz = math.sin(rZ);

	local Axx = cosX * cosY;
	local Axy = cosX * siy * siz - six * cosZ;
	local Axz = cosX * siy * cosZ + six * siz;

	local Ayx = six * cosY;
	local Ayy = six * siy * siz + cosX * cosZ;
	local Ayz = six * siy * cosZ - cosX * siz;

	local Azx = -siy;
	local Azy = cosY * siz;
	local Azz = cosY * cosZ;

	return(Axx * x + Axy * y + Axz * z),
		  (Ayx * x + Ayy * y + Ayz * z),
		  (Azx * x + Azy * y + Azz * z);
end
