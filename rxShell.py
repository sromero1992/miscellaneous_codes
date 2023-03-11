#!/usr/bin/env python

import os, sys
import numpy as np
import random as ran

def readFix(name):
    with open(name) as rfile:
        data = rfile.readlines()
    n = int(data[0])
#    ang = np.zeros((n,2))
    fup = []
    fdn = []
    for i in range(n):
        ele, sx, sy, sz = data[i+2].split()
        x = float(sx)
        y = float(sy)
        z = float(sz)
        if ele == 'X':
            fup.append([x, y, z])
        elif ele == 'He':
            fdn.append([x, y, z])
    vup = np.array(fup)
    vdn = np.array(fdn)
    '''
    rho = np.sqrt(x*x +y*y)
    if rho > 0.001:
        if y > 0:
            phi = np.arccos(x/rho)
        else:	
            phi = -np.arccos(x/rho)
    else:
        phi = 0.0
    theta = np.arccos(z)
    ang[i] = [phi, theta]
    pos[i] = [x, y, z]
    '''
    return vup, vdn


def writeDump(pos, k, e):
    wfile = open('dump.xyz','a')
    n = len(pos)
    wfile.write(str(n) +'\niter '+ str(k) +'  E= '+str(e) +'\n')
    for i in range(n):
        x, y, z = pos[i]
        wfile.write('X {0:12.6f}{1:12.6f}{2:12.6f}\n'.format(x, y, z))
    wfile.close()


def writeAll(fup, fdn):
    b = 1.889727
    nup = len(fup)
    ndn = len(fdn)
    frm = open('frmorb','w')
    xyz = open('fpos.xyz','w')
    frm.write('{0:5d}{1:5d}\n'.format(nup, ndn))
    xyz.write(str(nup +ndn) +'\n\n')
    for i in range(nup):
        x, y, z = fup[i]
        frm.write('{0:12.6f}{1:12.6f}{2:12.6f}\n'.format(b*x, b*y, b*z))
        xyz.write('X {0:12.6f}{1:12.6f}{2:12.6f}\n'.format(x, y, z))
    for i in range(ndn):
        x, y, z = fdn[i]
        frm.write('{0:12.6f}{1:12.6f}{2:12.6f}\n'.format(b*x, b*y, b*z))
        xyz.write('He{0:12.6f}{1:12.6f}{2:12.6f}\n'.format(x, y, z))
    frm.close()
    xyz.close()


def iniPositions(n, r):
    ang = np.zeros((n,2))
    pos = np.zeros((n,3))
    for i in range(n):
        phi = ran.uniform(-1,1) *np.pi
        theta = ran.uniform(-1,1) *np.pi/2
        ang[i] = [phi, theta]
        x = np.cos(phi) *np.sin(theta)
        y = np.sin(phi) *np.sin(theta)
        z = np.cos(theta)
        pos[i] = [r*x, r*y, r*z]
    return pos, ang


def coulomb(fix, move):
    energy = 0.0
    forces = []
    nf = len(fix)
    nm = len(move)
    for i in range(nm):
        fj = np.zeros(3)
        for j in range(nf):
            vij = move[i] -fix[j]
            dij = np.linalg.norm(vij)
            energy += 0.5/dij
            fj += vij/dij**3
        for j in range(nm):
            if i != j:
                vij = move[i] -move[j]
                dij = np.linalg.norm(vij)
                energy += 0.5/dij
                fj += vij/dij**3
    forces.append(fj) 
    return forces, energy


def MonteCarlo(fix, move, ang1, step, hmx):
    nm = len(move)
    r = np.linalg.norm(move[0])
    fs, en1 = coulomb(fix, move)
    k = 0
    h = 0
    nstep = 0
    if len(fix) == 0:
        ff = move
    else:
        ff = np.vstack((fix, move))
    writeDump(ff, k, en1)
#    for j in range(1,nstep):
    while h < hmx:
        nstep += 1
        ang2 = np.zeros((nm,2))
        for i in range(nm):
            dphi = step *ran.uniform(-1,1)*np.pi
            dtheta = step *ran.uniform(-1,1) *np.pi/2
            phi = ang1[i,0] +dphi
            theta = ang1[i,1] +dtheta
            ang2[i] = [phi, theta]
            x = np.cos(phi) *np.sin(theta)
            y = np.sin(phi) *np.sin(theta)
            z = np.cos(theta)
            move[i] = [r*x, r*y, r*z]
        fs, en2 = coulomb(fix, move)
        if en2 < en1:
            k = 0
            ang1 = ang2
            en1 = en2
            if len(fix) == 0:
                ff = move
            else:
                ff = np.vstack((fix, move))
            writeDump(ff, nstep, en1)
        else:
            k += 1
        if k > 9:
            step *= 0.9
            h += 1
    print nstep, en1


def ForceMin(ang, pos):
	k = 0
#	print ang, pos
#	forces, energy = coulomb(pos)
#	fm = np.linalg.norm(forces) /n
	writeDump(pos, k)
	epsilon = 1.0
	while epsilon > 0.0001:
		dfs = []
		forces, energy = coulomb(pos)
		fm = np.linalg.norm(forces) /n
		c = np.pi*step/fm
		for i in range(n):
			r = np.linalg.norm(pos[i])
			f = np.linalg.norm(forces[i])
			x, y, z = pos[i]
			rho = np.sqrt(x*x +y*y)
			if rho > 0.01:
				rphi = np.array([y, -x, 0.0])
				rthe = np.array([x*z, y*z, -rho**2]) /rho
				fphi = np.dot(forces[i], rphi) /rho
			else:
				rthe = np.array([r, 0.0, 0.0])
				fphi = 0.0
			fthe = np.dot(forces[i], rthe) /r
			ang[i] += [c*fphi, c*fthe]
			df = np.sqrt(fphi**2 +fthe**2) /f
			dfs.append(df)
		for i in range(n):
			phi, theta = ang[i]
			x = np.cos(phi) *np.sin(theta)
			y = np.sin(phi) *np.sin(theta)
			z = np.cos(theta)
			pos[i] = [x, y, z]
		epsilon = max(dfs)
#		e1 = e2
		k += 1
		writeDump(pos, k)
#	print ang, pos
	print k, energy, epsilon


if __name__ == '__main__':
    nlup = int(sys.argv[1])
#    nldn = int(sys.argv[2])

r = 1.0
if os.path.exists('dump.xyz'):
    os.system('rm dump.xyz')
#fup, fdn = readFix('fix22.xyz')
fup = []
move, ang = iniPositions(nlup, r)
MonteCarlo(fup, move, ang, 0.1, 80)
#fup = np.vstack((fup, move))
#move, ang = iniPositions(nldn, r)
#MonteCarlo(fdn, move, ang, 0.1, 80)
#fdn = np.vstack((fdn, move))
#ForceMin(ang, pos)
#writeAll(fup, fdn)
