/* eslint-disable jsx-a11y/alt-text */
import Image from 'next/image'
import Icon from '../../assets/images/icone-logo.png'
import styles from './style.module.scss'
import Link from 'next/link'

export function HeaderMain() {
    return (
        <header className={styles.cabecalho}>
            <div className={styles.container}>
                <Link href={'/'} className={styles['container-logo']}>
                    <Image
                        src={Icon}
                        alt='icon-logo'
                        width={46}
                        height={46}
                    />

                    <h1>ConsulTech</h1>
                </Link>

                <div className={styles['container-btns']}>
                    <Link href={'/login'} className={styles['link-login']}>Login</Link>
                    <Link href={'/cadastro'} className={styles['link-register']}>Cadastre-se</Link>
                </div>
            </div>
        </header>
    )
}

export function HeaderDoctor() {
    return (
        <header className={styles['cabecalho-doctor']}>
            <div className={styles.container}>
                <Link href={'/'} className={styles['container-logo']}>
                    <Image
                        src={Icon}
                        alt='icon-logo'
                        width={46}
                        height={46}
                        className={styles['icon-logo']}
                    />

                    <h1>ConsultTech</h1>
                </Link>

                <div className={styles['container-btns']}>
                    <Link href={'/medico'} className={styles['link-dados']}>Meus Dados</Link>
                    <Link href={'/medico/consultas-marcadas'} className={styles['link-consultas']}>Consultas Marcadas</Link>
                </div>
            </div>
        </header>
    )
}

export function HeaderPatient() {
    return (
        <header className={styles['cabecalho-paciente']}>
            <div className={styles.container}>
                <Link href={'/'} className={styles['container-logo']}>
                    <Image
                        src={Icon}
                        alt='icon-logo'
                        width={36}
                        height={36}
                        className={styles['icon-logo']}
                    />

                    <h1>ConsulTech</h1>
                </Link>

                <div className={styles['container-btns']}>
                    <Link href={'/paciente'} className={styles['link-dados']}>Meus Dados</Link>
                    <Link href={'/paciente/consultas'} className={styles['link-consultas']}>Consultas</Link>
                    <Link href={'/paciente/exames'} className={styles['link-consultas']}>Exames</Link>
                </div>
            </div>
        </header>
    )
}