import { FooterMain } from "@/components/footer";
import { HeaderDoctor } from "@/components/header";
import styles from './style.module.scss'
import Item from "./item";
import Link from "next/link";
import { RxExit } from "react-icons/rx";

export default function ConsultasMarcadas() {
    return (
        <>
            <HeaderDoctor />

            <main className={styles.menu}>
                <div className={styles.container}>
                    <h2>Consultas Marcadas</h2>

                    <ul className={styles.list}>
                        <div className={styles['header-list']}>
                            <span>Pacientes</span>
                            <span>Data</span>
                            <span>Turno</span>
                        </div>

                        <Item nome="Ricardo" data="25/10/2023" turno="Noite"/>
                        <Item nome="Nicolas" data="25/10/2023" turno="Manhã"/>
                        <Item nome="João" data="25/10/2023" turno="Tarde"/>
                    </ul>
                </div>
            </main>

            <Link href={'/'} className={styles['link-exit']}><RxExit size='28px'/></Link>

            <FooterMain />
        </>
    )
}