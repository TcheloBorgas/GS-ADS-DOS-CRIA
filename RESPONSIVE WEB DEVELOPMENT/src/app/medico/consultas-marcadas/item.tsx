'use client'
import styles from './style.module.scss'

interface iItem {
    nome: string;
    data: string;
    turno: string;
}

export default function Item({ nome, data, turno }: iItem) {
    return (
        <>
            <li className={styles.item}>
                <span>{nome}</span>
                <span>{data}</span>
                <span>{turno}</span>
            </li> 
        </>
    )
}