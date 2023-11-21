#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import tensorflow as tf
import numpy as np
import cv2
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Variaveis de controle❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
IMG_SIZE = 224
CATEGORIAS = ["tumor_glioma", "tumor_meningioma", "sem_tumor", "tumor_hipofisário"]
model = tf.keras.models.load_model('AI & CHATBOT\MRI\Model\model.h5')
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}



#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Funções Pred❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━



def prepare(image):
    new_array = cv2.resize(image, (IMG_SIZE, IMG_SIZE))
    return new_array.reshape(-1, IMG_SIZE, IMG_SIZE, 3)



def predict_tumor_type(image):
    image = prepare(image)
    image = image / 255.0
    predictions = model.predict(image)
    predicted_class_index = np.argmax(predictions, axis=1)
    predicted_class = CATEGORIAS[predicted_class_index[0]]
    predicted_probability = np.max(predictions, axis=1)[0]

    return predicted_probability, predicted_class




def allowed_file(filename):
        return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS