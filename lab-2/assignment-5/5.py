import numpy as np
import math 

def lefthand(sigma,d):
	lefthand = 1/(pow((2*(math.pi)),(d/2)) * pow(np.linalg.det(sigma),0.5));
	return lefthand

def righthand(sigma, mu, left):
	sigmainv = np.linalg.inv(sigma)
	x1 = ((sigmainv[0,0] * mu[0,0] * 2) + (sigmainv[1,0] * mu[1,0])*2)/2
	x2 = ((sigmainv[0,1] * mu[0,0] * 2) + (sigmainv[1,1] * mu[1,0])*2)/2
	x1exp = (sigmainv[0,0] / 2)
	x2exp = (sigmainv[1,1] / 2)
	x1x2 = ((sigmainv[1,0] + sigmainv[0,1]) / 2)
	f = np.log(left) -  ((sigmainv[0,0]*-mu[0,0]*-mu[0,0] + sigmainv[1,0]*-mu[1,0]*-mu[0,0] + sigmainv[1,0]*-mu[0,0]*-mu[1,0] + sigmainv[1,1]*-mu[1,0]*-mu[1,0])/2)

	""""
	print(x1exp)
	print(x1x2)
	print(x1)
	print(x2exp)
	print(x2)
	print(f)
	"""
	#print(str(-x1exp)+"x1^2 " + str(-x2exp)+"x2^2 + "+str(-x1x2)+"x1x2 + "+ str(x1)+"x1 "  + str(x2)+"x2 " +str(f))
	formula = str(-x1exp)+"x1^2 + " + str(-x2exp)+"x2^2 + "+str(-x1x2)+"x1x2 + "+ str(x1)+"x1 + "  + str(x2)+"x2 + " +str(f)
	return formula

	#print(str(-x1exp)+"x1^2 "+str(-x1x2)+"x1x2 + "+ str(x1)+"x1 " + str(-x2exp)+"x2^2 + " + str(x2)+"x2" +str(f))

def main():
	sigma1 = np.matrix('1 0;0 4')
	mu1 = np.matrix('3;5')

	sigma2 = np.matrix('2 0;0 1')
	mu2 = np.matrix('2;1')

	sigma3 = np.matrix('2.5 -1.5;-1.5 2.5')
	mu3 = np.matrix('6;4')

	sigma4 = np.matrix('1 0;0 1')
	mu4 = np.matrix('3;1')

	d = 2

	left1 = lefthand(sigma1, d)
	left2 = lefthand(sigma2, d)
	g1 = righthand(sigma1, mu1, left1)
	g2 = righthand(sigma2, mu2, left2)
	print("g1 = " + g1)
	print("g2 = " + g2)


main()