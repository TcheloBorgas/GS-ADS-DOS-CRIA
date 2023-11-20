#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import tensorflow as tf
import numpy as np
import cv2
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

IMG_SIZE = 224
CATEGORIAS = ["tumor_glioma", "tumor_meningioma", "sem_tumor", "tumor_hipofisário"]
model = tf.keras.models.load_model('AI & CHATBOT\MRI\Model\model.h5')

def prepare(image):
    new_array = cv2.resize(image, (IMG_SIZE, IMG_SIZE))
    return new_array.reshape(-1, IMG_SIZE, IMG_SIZE, 3)

def predict_tumor_type(image):
    image = prepare(image)
    image = image / 255.0
    prediction = model.predict(image)
    prediction = np.argmax(prediction, axis=1)
    return CATEGORIAS[prediction[0]]
