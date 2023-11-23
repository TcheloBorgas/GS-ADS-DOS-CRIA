import styles from './style.module.scss'
import { FaCopyright } from "react-icons/fa";
import GitHubIcon from '../../assets/images/github.png'
import Image from 'next/image';
import Link from 'next/link';

export function FooterMain() {
    return (
        <footer className={styles.rodape}>
            <div className={styles.list}>
                <Link href={'https://github.com/RicardoBritoFiap'} target='_blank' className={styles['link-github']}><Image src={GitHubIcon} alt={'github-icon'} width={26} height={26}/>Ricardo Brito - RM 98370</Link>
                <Link href={'https://github.com/komatsuhenry1'} target='_blank' className={styles['link-github']}><Image src={GitHubIcon} alt={'github-icon'} width={26} height={26}/>Henry Ribeiro Komatsu - RM 550684</Link>
                <Link href={'https://github.com/nicolasinohue'} target='_blank' className={styles['link-github']}><Image src={GitHubIcon} alt={'github-icon'} width={26} height={26}/>Nicolas Eiti Inohue - RM 98057</Link>
                <Link href={'https://github.com/Nxtlevelbr'} target='_blank' className={styles['link-github']}><Image src={GitHubIcon} alt={'github-icon'} width={26} height={26}/>Marcel Prado Soddano - RM 99841</Link>
                <Link href={'https://github.com/TcheloBorgas'} target='_blank' className={styles['link-github']}><Image src={GitHubIcon} alt={'github-icon'} width={26} height={26}/>Marcelo Henrique Borgas - RM 98893</Link>
            </div>

            <span><FaCopyright size='32px' color='white'/>2023 por ConsulTech.</span>
        </footer>
    )
}