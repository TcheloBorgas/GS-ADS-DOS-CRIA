import styles from './style.module.scss'

interface iExame {
    nome: string;
    resultado: string;
}

export default function ItemExame({ nome, resultado }: iExame) {
    return (
        <li className={styles.item}>
            <span>{nome}</span>
            <span>{resultado}</span>
        </li>
    )
}