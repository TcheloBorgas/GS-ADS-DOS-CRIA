'use client'
import { useDropzone } from 'react-dropzone'
import styles from './style.module.scss'
import { useCallback, useState } from 'react'
import { zodResolver } from '@hookform/resolvers/zod'
import { SubmitHandler, useForm } from 'react-hook-form'
import { iExam } from '@/interfaces/paciente.interfaces'
import { sendExamSchema } from '@/schemas/paciente.schemas'

export default function FormExams() {
    const [dropFile, setFile] = useState<File | null>(null)

    const onDrop = useCallback((file: File[]) => {
        setFile(file[0])
    }, [setFile])

    const { getRootProps, getInputProps } = useDropzone({
        onDrop,
        accept: {
            "image/jpeg": [".jpg", ".jpeg"],
            "image/png": [".png"],
            "application/pdf": [".pdf"]
        }
    })

    const { register, handleSubmit, formState: { errors } } = useForm<iExam>({
        resolver: zodResolver(sendExamSchema),
    })

    const registerDoctor: SubmitHandler<iExam> = (data: iExam) => {
        console.log(data)
    };

    return (
        <form className={styles['form-exams']} onSubmit={handleSubmit(registerDoctor)}>
            <div>
                <div className={styles['box-input']}>
                    <label htmlFor="leukocytes">Leukocytes</label>
                    <input type="text" id="leukocytes" placeholder=" Leukocytes" { ...register('leukocytes') }/>
                </div>

                { errors.leukocytes?.message ? <span className={styles['span-error']}>{errors.leukocytes.message}</span> : null }
            </div>

            <div>
                <div className={styles['box-input']}>
                    <label htmlFor="platelets">Platelets</label>
                    <input type="text" id="platelets" placeholder="Platelets" { ...register('platelets') }/>
                </div>

                { errors.platelets?.message ? <span className={styles['span-error']}>{errors.platelets.message}</span> : null }
            </div>

            <div>
                <div className={styles['box-input']}>
                    <label htmlFor="mean-platelet-volume">Mean Platelet Volume</label>
                    <input type="text" id="mean-platelet-volume" placeholder="Mean platelet volume" { ...register('meanPlateletVolume') }/>
                </div>
            
                { errors.meanPlateletVolume?.message ? <span className={styles['span-error']}>{errors.meanPlateletVolume.message}</span> : null }
            </div>

            <div>
                <div className={styles['box-input']}>
                    <label htmlFor="eosinophils">Eosinophils</label>
                    <input type="text" id="eosinophils" placeholder="Eosinophils" { ...register('eosinophils') }/>
                </div>
            
                { errors.eosinophils?.message ? <span className={styles['span-error']}>{errors.eosinophils.message}</span> : null }
            </div>

            <div>
                <div className={styles['box-input']}>
                    <label htmlFor="proteina-c ">Proteína C reativa mg/dL</label>
                    <input type="text" id="proteina-c" placeholder="Proteina C reativa mg/dL" { ...register('proteinaCReativa') }/>
                </div>
            
                { errors.proteinaCReativa?.message ? <span className={styles['span-error']}>{errors.proteinaCReativa.message}</span> : null }
            </div>

            <div className={styles['div-dropfile']} { ...getRootProps() }>
                <label htmlFor="dropzone-file">Envie seu Arquivo</label>

                <div style={{display: 'flex', alignItems: 'center', marginBottom: '20px'}}>
                    <input type="button" id="drop-file" value='Escolher arquivo'/>
                    <input style={{display: "none"}} id="dropzone-file" placeholder='Escolher arquivo' { ...getInputProps() }/>

                    <span>{dropFile === null ? 'Nenhum arquivo selecionado...' : dropFile.name}</span>
                </div>
            </div>

            <button type='submit'>Enviar Pré-Diagnóstico</button>
        </form>
    )
}