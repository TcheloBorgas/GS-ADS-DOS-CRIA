'use client'
import styles from './style.module.scss'
import { PiTrashSimpleFill } from "react-icons/pi";

interface iItem {
    nome: string;
    data: string;
    horario: string;
}

interface iItemDoctor {
    nome: string;
    endereco: string;
    estado: string;
    cidade: string;
    cep: string;
}

export function Item({ nome, data, horario }: iItem) {
    return (
        <li className={styles.item}>
            <div>
                <span>{nome}</span>
                <span>{data}</span>
                <span>{horario}</span>
            </div>

            <button><PiTrashSimpleFill className={styles['icon-trash']} size='20px'/></button>
        </li> 
    )
}

export function ItemDoctor({ nome, endereco, estado, cidade, cep }: iItemDoctor) {
    const newDate = new Date()
    const dateFormat = newDate.toLocaleDateString()
    const date = dateFormat.split('/')
    
    return (
        <>
            <div className={styles['item-doctor']}>
                <h3>{nome}</h3>

                <p className={styles.address}>Endereço: {endereco}</p>
                <p className={styles.address}>Estado: {estado}</p>
                <p className={styles.address}>Cidade: {cidade}</p>
                <p className={styles.address}>CEP: {cep}</p>

                <div className={styles['box-select']}>
                    <label htmlFor="day">Dias de Atendimento</label>

                    <select name="dia" id='day'>
                    <option value="">---</option>
                        <option value="">{dateFormat}</option>
                        <option value="">{`${+date[0] + 1}/${date[1]}/${date[2]}`}</option>
                        <option value="">{`${+date[0] + 2}/${date[1]}/${date[2]}`}</option>
                        <option value="">{`${+date[0] + 3}/${date[1]}/${date[2]}`}</option>
                        <option value="">{`${+date[0] + 4}/${date[1]}/${date[2]}`}</option>
                        <option value="">{`${+date[0] + 5}/${date[1]}/${date[2]}`}</option>
                    </select>
                </div>

                <div className={styles['box-select']} style={{marginTop: '10px'}}>
                    <label htmlFor="turn">Horário de Atendimento</label>

                    <select name="Turno" id='turn'>
                    <option value="">---</option>
                        <option value="08h">08:00</option>
                        <option value="09h">09:00</option>
                        <option value="10h">10:00</option>
                        <option value="11h">11:00</option>
                        <option value="12h">12:00</option>
                        <option value="13h">13:00</option>
                        <option value="14h">14:00</option>
                        <option value="15h">15:00</option>
                        <option value="16h">16:00</option>
                        <option value="17h">17:00</option>
                        <option value="18h">18:00</option>
                    </select>
                </div>

                <button className={styles['btn-send']}>Marcar Consulta</button>
            </div>
        </>
    )
}