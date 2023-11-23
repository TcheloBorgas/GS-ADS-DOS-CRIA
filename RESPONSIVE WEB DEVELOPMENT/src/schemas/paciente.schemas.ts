import { z } from "zod";

const updatePatientSchema = z.object({
    nome: z.string().max(150, 'Máximo de 150 caracteres').nullish(),
    email: z.union([z.string().email('Forneça um e-mail válido').nullish().default(null), z.string().max(0)]),
    senha: z.union([z.string()
        .min(8, "A senha precisa conter pelo menos 8 caracteres")
        .regex(/(?=.*?[#?!@$%^&*-])/, "É necessário pelo menos um caracter especial")
        .regex(/(?=.*?[A-Z])/, "É necessário pelo menos uma letra maiúscula")
        .regex(/(?=.*?[a-z])/, "É necessário pelo menos uma letra minúscula")
        .nullish().default(null), z.string().max(0)]),
    cpf: z.union([z.string().min(11, 'Mínimo de 11 dígitos').max(11, 'Máximo de 11 dígitos').nullish(), z.string().max(0)]),
    idade: z.union([z.string().nonempty("Idade obrigatória").max(3, 'Máximo de 3 dígitos'), z.string().max(0)]),
    endereco: z.union([z.string().nonempty('Endereço obrigatório').min(6, 'Exemplo: Rua Fagundes, 58').max(80, 'Máximo de 80 caracteres'), z.string().max(0)])
})

const sendExamSchema = z.object({
    leukocytes: z.string().nonempty('Leukocytes obrigatório'),
    platelets: z.string().nonempty('Platelets obrigatório'),
    meanPlateletVolume: z.string().nonempty('Mean Platelet Volume obrigatório'),
    eosinophils: z.string().nonempty('Eosinophils obrigatório'),
    proteinaCReativa: z.string().nonempty('Proteína C reativa mg/dL obrigatória')
})

export {
    updatePatientSchema,
    sendExamSchema
}