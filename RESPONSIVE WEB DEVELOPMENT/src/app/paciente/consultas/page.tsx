import { FooterMain } from "@/components/footer";
import { HeaderPatient } from "@/components/header";
import styles from './style.module.scss'
import { Item, ItemDoctor } from "./items";
import { FaSearch } from "react-icons/fa";
import Link from "next/link";
import { RxExit } from "react-icons/rx";

export default function Consultas() {
    return (
        <>
            <HeaderPatient />

            <menu className={styles.menu}>
                <div className={styles.container}>
                    <section className={styles['section-make-appointment']}>
                        <h2>Marcar Consultas</h2>

                        <div className={styles['box-search']}>
                            <input type="text" placeholder='Pesquisar por nome, CRM ou especialidade'/>
                            <button type="button"><FaSearch size='28px' className={styles.search}/></button>
                        </div>

                        <ItemDoctor endereco='Rua Fagundes, 58' estado='Rio de Janeiro' cidade='Petrópolis' cep={`12547-259`} nome='Ricardo Santos'/>
                    </section>

                    <section className={styles['section-scheduled-appointments']}>
                        <h2>Consultas Marcadas</h2>

                        <ul className={styles.list}>
                            <div className={styles['header-list']}>
                                <span>Medico</span>
                                <span>Data</span>
                                <span>Turno</span>
                            </div>   

                            <Item nome="Ricardo" data="25/10/2023" horario="Manhã"/>
                            <Item nome="Nicolas" data="25/10/2023" horario="Tarde"/>
                            <Item nome="João" data="25/10/2023" horario="Tarde"/>
                            <Item nome="Pedro" data="25/10/2023" horario="Noite"/>

                        </ul>
                    </section>
                </div>
            </menu>

            <Link href={'/'} className={styles['link-exit']}><RxExit size='28px'/></Link>


            <FooterMain/>
        </>
    )
}