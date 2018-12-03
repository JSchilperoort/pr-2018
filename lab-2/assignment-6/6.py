import numpy as np
import math 


def main():
	P_spam = 0.9
	P_nonspam = 0.1
	p_dict = {'anti-aging': [0.00062,0.000000035],
				'customers': [0.005,0.0001],
				'fun': [0.00015,0.0007],
				'groningen': [0.00001,0.001],
				'lecture': [0.000015,0.0008],
				'money': [0.002,0.0005],
				'vacation': [0.00025,0.00014],
				'viagra': [0.001,0.0000003],
				'watches': [0.0003,0.000004] }


	sentences = ["We offer our dear customers a wide selection of classy watches.", "Did you have fun on vacation? I sure did!"]


	for sent in sentences:
		print(sent)
		probability = 1
		p_spam = 1
		p_nonspam = 1
		sent = sent.lower()
		sent = sent.split()
		for word in sent:
			try:
				word_p_spam = p_dict[word][0]
				word_p_nonspam = p_dict[word][1]
				p = word_p_spam / word_p_nonspam

				p_spam *= word_p_spam
				p_nonspam *= word_p_nonspam
				probability *= p
			except:
				pass

		p_spam *= P_spam 
		p_nonspam *= P_nonspam


		print("Probability of spam nominator: " + str(p_spam))
		print("Probability of non-spam nominator: " + str(p_nonspam))

		print("Probability of spam: " + str(p_spam/p_nonspam))
		print("Probability of non-spam: " + str(p_nonspam/p_spam))
		print("\n")

if __name__ == "__main__":
	main()

