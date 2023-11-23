'use client'
import { SubmitHandler, useForm } from 'react-hook-form';
import styles from './style.module.scss'
import { iRegisterDoctor, iRegisterPatient } from '@/interfaces/cadastro.interfaces';
import { zodResolver } from '@hookform/resolvers/zod';
import { registerDoctorSchema, registerPatientSchema } from '@/schemas/cadastro.schemas';
import Link from 'next/link';
import { iLogin } from '@/interfaces/login.interfaces';
import { loginSchema } from '@/schemas/login.schemas';
import { iUpdateMedico } from '@/interfaces/medico.interfaces';
import { iUpdatePatient } from '@/interfaces/paciente.interfaces';
import { updatePatientSchema } from '@/schemas/paciente.schemas';


export function FormPatient() {
    const { register, handleSubmit, formState: { errors } } = useForm<iRegisterPatient>({
        resolver: zodResolver(registerPatientSchema),
    })

    const registerPatient: SubmitHandler<iRegisterPatient> = (registerData: iRegisterPatient) => {
        console.log(registerData)
    };

    return (
        <form onSubmit={handleSubmit(registerPatient)} className={styles.formulario}>
            <div className={styles['div-inputs']}>
                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="name">Nome</label>
                        <input id="name" type="text" placeholder="Nome Completo" { ...register('nome') }/>
                    </div>

                    <span className={errors.nome?.message ? styles['span-error'] : undefined}>{errors.nome?.message ? errors.nome.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="mail">Email</label>
                        <input id="mail" type="email" placeholder="joao123@gmail.com" { ...register('email') }/>
                    </div>

                    <span className={errors.email?.message ? styles['span-error'] : undefined}>{errors.email?.message ? errors.email.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="password">Senha</label>
                        <input id="password" type="password" placeholder="Senha" { ...register('senha') }/>
                    </div>

                    <span className={errors.senha?.message ? styles['span-error'] : undefined}>{errors.senha?.message ? errors.senha.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="cpf">CPF</label>
                        <input id="cpf" type="text" placeholder="CPF" { ...register('cpf') }/>
                    </div>

                    <span className={errors.cpf?.message ? styles['span-error'] : undefined}>{errors.cpf?.message ? errors.cpf.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="age">Data de Nascimento</label>
                        <input id="age" type="text" placeholder="dd/mm/yyyy" { ...register('dataNascimento') }/>
                    </div>

                    <span className={errors.dataNascimento?.message ? styles['span-error'] : undefined}>{errors.dataNascimento?.message ? errors.dataNascimento.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="sexo">Sexo</label>
                        <input id="sexo" type="text" placeholder="joao123@gmail.com" { ...register('sexo') }/>
                    </div>

                    <span className={errors.sexo?.message ? styles['span-error'] : undefined}>{errors.sexo?.message ? errors.sexo.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="address">Logradouro</label>
                        <input id="address" type="text" placeholder="Rua Fagundes" { ...register('logradouro') }/>
                    </div>

                    <span className={errors.logradouro?.message ? styles['span-error'] : undefined}>{errors.logradouro?.message ? errors.logradouro.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="number">Número</label>
                        <input id="number" type="text" placeholder="1548" { ...register('numero') }/>
                    </div>

                    <span className={errors.numero?.message ? styles['span-error'] : undefined}>{errors.numero?.message ? errors.numero.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="uf">UF</label>
                        <input id="uf" type="text" placeholder="SP" { ...register('uf') }/>
                    </div>

                    <span className={errors.uf?.message ? styles['span-error'] : undefined}>{errors.uf?.message ? errors.uf.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="city">Cidade</label>
                        <input id="city" type="text" placeholder="Campinas" { ...register('cidade') }/>
                    </div>

                    <span className={errors.cidade?.message ? styles['span-error'] : undefined}>{errors.cidade?.message ? errors.cidade.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="district">Bairro</label>
                        <input id="district" type="text" placeholder="Cidade Jardim" { ...register('bairro') }/>
                    </div>

                    <span className={errors.bairro?.message ? styles['span-error'] : undefined}>{errors.bairro?.message ? errors.bairro.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="cep">CEP</label>
                        <input id="cep" type="text" placeholder="12589600" { ...register('cep') }/>
                    </div>

                    <span className={errors.cep?.message ? styles['span-error'] : undefined}>{errors.cep?.message ? errors.cep.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="complement">Complemento</label>
                        <input id="complement" type="text" placeholder="Rua Fagundes, 58" { ...register('complemento') }/>
                    </div>
                </div>
            </div>

            <Link href={"/login"} className={styles['link-login']}>Já possui uma conta? Faça o seu login</Link>

            <button type="submit" className={styles['btn-cadastro']}>Cadastre-se</button>
        </form>    
    )
}

export function FormDoctor() {
    const { register, handleSubmit, formState: { errors } } = useForm<iRegisterDoctor>({
        resolver: zodResolver(registerDoctorSchema),
    })

    const registerDoctor: SubmitHandler<iRegisterDoctor> = (registerData: iRegisterDoctor) => {
        console.log(registerData)
    };

    return (
        <form onSubmit={handleSubmit(registerDoctor)} className={styles.formulario}>
            <div className={styles['div-inputs']}>
                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="name">Nome</label>
                        <input id="name" type="text" placeholder="Nome Completo" { ...register('nome') }/>
                    </div>

                    <span className={errors.nome?.message ? styles['span-error'] : undefined}>{errors.nome?.message ? errors.nome.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="mail">Email</label>
                        <input id="mail" type="email" placeholder="joao123@gmail.com" { ...register('email') }/>
                    </div>

                    <span className={errors.email?.message ? styles['span-error'] : undefined}>{errors.email?.message ? errors.email.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="password">Senha</label>
                        <input id="password" type="password" placeholder="Senha" { ...register('senha') }/>
                    </div>

                    <span className={errors.senha?.message ? styles['span-error'] : undefined}>{errors.senha?.message ? errors.senha.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="crm">CRM</label>
                        <input id="crm" type="text" placeholder="CRM" { ...register('crm') }/>
                    </div>

                    <span className={errors.crm?.message ? styles['span-error'] : undefined}>{errors.crm?.message ? errors.crm.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="specialty">Especialidade</label>
                        <input id="specialty" type="text" placeholder="Rua Fagundes, 58" { ...register('especialidade') }/>
                    </div>

                    <span className={errors.especialidade?.message ? styles['span-error'] : undefined}>{errors.especialidade?.message ? errors.especialidade.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="phone">Telefone</label>
                        <input id="phone" type="text" placeholder="11985784596" { ...register('telefone') }/>
                    </div>

                    <span className={errors.telefone?.message ? styles['span-error'] : undefined}>{errors.telefone?.message ? errors.telefone.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="address">Logradouro</label>
                        <input id="address" type="text" placeholder="Rua Fagundes" { ...register('logradouro') }/>
                    </div>

                    <span className={errors.logradouro?.message ? styles['span-error'] : undefined}>{errors.logradouro?.message ? errors.logradouro.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="number">Número</label>
                        <input id="number" type="text" placeholder="1548" { ...register('numero') }/>
                    </div>

                    <span className={errors.numero?.message ? styles['span-error'] : undefined}>{errors.numero?.message ? errors.numero.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="uf">UF</label>
                        <input id="uf" type="text" placeholder="SP" { ...register('uf') }/>
                    </div>

                    <span className={errors.uf?.message ? styles['span-error'] : undefined}>{errors.uf?.message ? errors.uf.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="city">Cidade</label>
                        <input id="city" type="text" placeholder="Campinas" { ...register('cidade') }/>
                    </div>

                    <span className={errors.cidade?.message ? styles['span-error'] : undefined}>{errors.cidade?.message ? errors.cidade.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="district">Bairro</label>
                        <input id="district" type="text" placeholder="Cidade Jardim" { ...register('bairro') }/>
                    </div>

                    <span className={errors.bairro?.message ? styles['span-error'] : undefined}>{errors.bairro?.message ? errors.bairro.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="cep">CEP</label>
                        <input id="cep" type="text" placeholder="12589600" { ...register('cep') }/>
                    </div>

                    <span className={errors.cep?.message ? styles['span-error'] : undefined}>{errors.cep?.message ? errors.cep.message : null}</span>
                </div>

                <div className={styles['div-input']}>
                    <div className={styles['container-input']}>
                        <label htmlFor="complement">Complemento</label>
                        <input id="complement" type="text" placeholder="Rua Fagundes, 58" { ...register('complemento') }/>
                    </div>
                </div>
            </div>

            <Link href={"/login"} className={styles['link-login']}>Já possui uma conta? Faça o seu login</Link>

            <button type="submit" className={styles['btn-cadastro']}>Cadastre-se</button>
        </form>    
    )
}

export function FormUpdateDoctor() {
    const { register, handleSubmit } = useForm<iUpdateMedico>({
        resolver: zodResolver(registerDoctorSchema),
    })


    const updateDoctor: SubmitHandler<iUpdateMedico> = (registerData: iUpdateMedico) => {
        console.log(registerData)
    };

    return (
        <form onSubmit={handleSubmit(updateDoctor)} className={styles['form-update-doctor']}>
            <div className={styles['div-input']}>
                <label htmlFor="name">Nome</label>
                <input type="text" id='name' placeholder='Nome' { ...register('nome') }/>
            </div>

            <div className={styles['div-input']}>
                <label htmlFor="mail">Email</label>
                <input type="text" id='mail' placeholder='Email' { ...register('email') }/>
            </div>

            <div className={styles['div-input']}>
                <label htmlFor="password">Senha</label>
                <input type="password" id='password' placeholder='Senha' { ...register('senha') }/>
            </div>

            <div className={styles['div-input']}>
                <label htmlFor="cpf">CPF</label>
                <input type="text" id='cpf' placeholder='CPF' { ...register('cpf') }/>
            </div>

            <div className={styles['div-input']}>
                <label htmlFor="crm">CRM</label>
                <input type="text" id='crm' placeholder='CRM' { ...register('crm') }/>
            </div>

            <div className={styles['div-input']}>
                <label htmlFor="endereco">Endereço</label>
                <input type="text" id='endereco' placeholder='Endereço' { ...register('endereco') }/>
            </div>

            <div className={styles['div-input']}>
                <label htmlFor="state">Estado</label>
                <input type="text" id='state' placeholder='Estado' { ...register('estado') }/>
            </div>

            <div className={styles['div-input']}>
                <label htmlFor="city">Cidade</label>
                <input type="text" id='city' placeholder='Cidade' { ...register('cidade') }/>
            </div>

            <div className={styles['div-input']}>
                <label htmlFor="cep">CEP</label>
                <input type="text" id='cep' placeholder='CEP' { ...register('cep') }/>
            </div>

            <div className={styles['div-checkbox']}>
                <h3>Turnos de Atendimento</h3>

                <div>
                    <div className={styles['box-checkbox']}>
                        <label htmlFor="manha">Manhã</label>
                        <input type="checkbox" name="manha" id="manha" />
                    </div>

                    <div>
                        <label htmlFor="tarde">Tarde</label>
                        <input type="checkbox" name="tarde" id="tarde" />
                    </div>

                    <div>
                        <label htmlFor="noite">Noite</label>
                        <input type="checkbox" name="noite" id="noite" />
                    </div>
                </div>
            </div>

            <div className={styles['box-btns']}>
                <button type="submit" className={styles['btn-exclude']}>Excluir Conta</button>
                <button type="submit" className={styles['btn-update']}>Atualizar Dados</button>
            </div>
        </form>    
    )
}

export function FormUpdatePatient() {
    const { register, handleSubmit } = useForm<iUpdatePatient>({
        resolver: zodResolver(updatePatientSchema),
    })


    const updateDoctor: SubmitHandler<iUpdatePatient> = (registerData: iUpdatePatient) => {
        console.log(registerData)
    };

    return (
        <form onSubmit={handleSubmit(updateDoctor)} className={styles['form-update-doctor']}>
            <div className={styles['div-input']}>
                <label htmlFor="name">Nome</label>
                <input type="text" id='name' placeholder='Nome' { ...register('nome') }/>
            </div>

            <div className={styles['div-input']}>
                <label htmlFor="mail">Email</label>
                <input type="text" id='mail' placeholder='Email' { ...register('email') }/>
            </div>

            <div className={styles['div-input']}>
                <label htmlFor="password">Senha</label>
                <input type="password" id='password' placeholder='Senha' { ...register('senha') }/>
            </div>

            <div className={styles['div-input']}>
                <label htmlFor="cpf">CPF</label>
                <input type="text" id='cpf' placeholder='CPF' { ...register('cpf') }/>
            </div>

            <div className={styles['div-input']}>
                <label htmlFor="age">Idade</label>
                <input type="text" id='age' placeholder='Idade' { ...register('idade') }/>
            </div>

            <div className={styles['div-input']}>
                <label htmlFor="endereco">Endereço</label>
                <input type="text" id='endereco' placeholder='Endereço' { ...register('endereco') }/>
            </div>

            <div className={styles['box-btns']}>
                <button type="submit" className={styles['btn-exclude']}>Excluir Conta</button>
                <button type="submit" className={styles['btn-update']}>Atualizar Dados</button>
            </div>
        </form>    
    )
}

export function FormLogin() {
    const { register, handleSubmit, formState: { errors } } = useForm<iLogin>({
        resolver: zodResolver(loginSchema),
    })

    const submitLogin: SubmitHandler<iLogin> = (registerData: iLogin) => {
        console.log(registerData)
    };

    return (
            <form className={styles.formulario} onSubmit={handleSubmit(submitLogin)}>
                <div className={styles['div-inputs']}>
                    <div className={styles['div-input']}>
                        <div className={styles['container-input']}>
                            <label htmlFor="mail">Email</label>
                            <input id="mail" type="text" placeholder="Email" { ...register('email') }/>
                        </div>
                        <span className={errors.email?.message ? styles['span-error'] : undefined}>{errors.email?.message ? errors.email.message : null}</span>
                    </div>
                    
                    <div className={styles['div-input']}>
                        <div className={styles['container-input']}>
                            <label htmlFor="password">Senha</label>
                            <input id="password" type="password" placeholder="Senha" { ...register('senha') }/>
                        </div>
                        <span className={errors.senha?.message ? styles['span-error'] : undefined}>{errors.senha?.message ? errors.senha.message : null}</span>
                    </div>
                </div>

                <button type='submit' className={styles['login-paciente']}>Login Paciente</button>
                <button type='submit' className={styles['login-medico']}>Login Médico</button>
            </form>
    )
}