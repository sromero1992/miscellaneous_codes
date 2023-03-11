#!/usr/bin/env python

import sys, os, math
#import numpy as np

def readXYZ(sysfile):

	with open(sysfile) as sfile:
		data = sfile.readlines()
	n = int(data[0])
	atpos = []
	for i in range(n):
		ele, sx, sy, sz = data[i+2].split()
		x = float(sx)
		y = float(sy)
		z = float(sz)
		atpos.append([ele,x,y,z])
	return atpos


def FODxyz(lines):

	f = 0.529177
        nsp = lines[0].split()
        nup = int(nsp[0])
        ndn = int(nsp[1])
	fodpos = []
	for i in range(nup):
		sx, sy, sz = lines[i+1].split()[:3]
		x = f*float(sx)
		y = f*float(sy)
		z = f*float(sz)
		fodpos.append(['X', x, y, z])
        for i in range(ndn):
		sx, sy, sz = lines[nup+i+1].split()[:3]
		x = f*float(sx)
		y = f*float(sy)
		z = f*float(sz)
		fodpos.append(['He', x, y, z])
	return fodpos


def sortFOD(atoms, fods):

        natm = len(atoms)
        nfod = len(fods)
        avec = [] #512*np.ones(nfod, dtype=np.int16)
        dvec = [] #np.zeros(nfod)
        for i in range(nfod):
                ele, xi, yi, zi = fods[i]
                dmin = 10.0
                for j in range(natm):
                        ele, xj, yj, zj = atoms[j]
                        dij = math.sqrt((xi-xj)**2 +(yi-yj)**2 +(zi-zj)**2)
                        if dij < dmin:
                                dmin = dij
                                ai = j
                                di = dij
                avec.append(ai)
                dvec.append(di)
        atfod = []
        dists = []
        for j in range(natm):
                ele = atoms[j][0]
                atfod.append(atoms[j])
                jfods = []
                for i in range(nfod):
                        if avec[i] == j:
                                e, x, y, z = fods[i]
                                jfods.append([dvec[i], e, x, y, z])
                jfods.sort()
                nfj = len(jfods)
                for i in range(nfj):
                        d, e, x, y, z = jfods[i]
                        atfod.append([e, x, y, z])
                        dists.append(d)

                print j+1, ele, nfj, 'FODs'
        return atfod, dists


def writeXYZ(atpos, dists, step):

    n = len(atpos)
    if step == 0:
        wfile = open('atm-fod.xyz','w')
        wfile.write(str(n) +'\n\n')
    else:
        wfile = open('optim.xyz','a')
        wfile.write(str(n) +'\nStep '+ str(step) +'.\n')
    k = 0
    for ele, x, y, z in atpos:
        if ele == 'X' or ele == 'He':
            wfile.write('{0:2s}{1:15.8f}{2:15.8f}{3:15.8f} #{4:15.8f}\n'
                        .format(ele, x, y, z, dists[k]))
            k += 1
        else:
	    wfile.write('{0:2s}{1:15.8f}{2:15.8f}{3:15.8f}\n'.format(ele, x, y, z))
    wfile.close()


def rwFOD(atoms, fodfile):

    if fodfile == 'records':
        with open(fodfile) as ffile:
	    data = ffile.readlines()
        os.system('rm optim.xyz')
        nsp = data[1].split()
        nfod = int(nsp[0]) +int(nsp[1])
        stride = 2*nfod +3
        nsteps = len(data) /stride
        for i in range(nsteps):
            print 'Step ', i+1
            istart = i*stride +1
            iend = istart +nfod +1
            lines = data[istart:iend]
            fods = FODxyz(lines)
            atfod, dists = sortFOD(atoms, fods)
            writeXYZ(atfod, dists, i+1)
    else:
        os.system("sed -e 's/D/E/g' "+ fodfile +" > tfile")
        os.system('mv tfile '+ fodfile)
        with open(fodfile) as ffile:
	    data = ffile.readlines()
        fods = FODxyz(data)
        atfod, dists = sortFOD(atoms, fods)
        writeXYZ(atfod, dists, 0)


if __name__ == '__main__':
#	sysfile = sys.argv[1]
	fodfile = sys.argv[1]

sysfile = 'XMOL.xyz'
atoms = readXYZ(sysfile)
rwFOD(atoms, fodfile)

