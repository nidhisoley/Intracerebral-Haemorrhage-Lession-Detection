## Intracerebral-Haemorrhage-Lession-Detection
Intracerebral hemorrhage (ICH) is caused by bleeding within the brain tissue itself — a life-threatening type of stroke. A stroke occurs when the brain is deprived of oxygen and blood supply. ICH is most commonly caused by hypertension, arteriovenous malformations, or head trauma. Treatment focuses on stopping the bleeding, removing the blood clot (hematoma), and relieving the pressure on the brain.

Computer-Aided Diagnosis (CAD) systems use computers to help physicians reach a fast and accurate diagnosis. CAD systems are usually domain-specific as they are optimized for certain types of diseases, parts of the body, diagnosis methods, etc. They analyse different kinds of input such as symptoms, laboratory tests results, medical images, etc. depending on their domain. One of the most common types of diagnosis is the one that depends on medical images. Such systems are very useful since they can be integrated with the software of the medical imaging machine to provide quick and accurate diagnosis. On the other hand, they can be challenging since they combine the elements of artificial intelligence and digital image processing. This work presents a CAD system to help detect haemorrhages in CT scans of human brains and identify their types if they exist. As with other CAD systems, the motivations for building this system are:

(i) reducing human errors (it is well-known that the performance of human experts can drop below acceptable levels if they are distracted, stressed, overworked, emotionally unbalanced, etc.)

(ii) reducing the time/effort associated with training and hiring physicians.
Eventually, this system can be integrated within the software of CT imaging devices to enable users to produce a quick and highly accurate diagnosis while generating the image. The proposed system can also be helpful for teaching and research purposes. It can be used to train senior medical students as well as resident doctors.

The proposed method in CAD consists of three main steps image enhancement, Morphological dilation, erosion and highlighting the abnormal slices. A windowing operation is performed on the intensity distribution to enhance the region of interest. Domain knowledge about the anatomical structure of the skull and the brain is used to detect abnormalities in a rotation- and translation-invariant manner.

![image](https://user-images.githubusercontent.com/71967651/128643876-9c907bf2-1194-4307-9683-bde353fd1b62.png)
