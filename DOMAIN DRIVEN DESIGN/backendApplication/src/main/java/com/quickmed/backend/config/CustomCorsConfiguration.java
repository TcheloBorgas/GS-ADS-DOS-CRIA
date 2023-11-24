package com.quickmed.backend.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebMvc
public class CustomCorsConfiguration implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        // Configuração global para todas as páginas
        registry.addMapping("/**")
                .allowedOrigins("http://localhost:3000")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS", "HEAD", "TRACE", "CONNECT")
                .allowedHeaders("*")
                .exposedHeaders("Authorization")
                .allowCredentials(true)
                .maxAge(3600);

        // Configuração específica para a página /medico
        configureCorsForPage(registry, "/medico/**");

        // Configuração específica para a página /paciente
        configureCorsForPage(registry, "/paciente/**");

        // Configuração específica para a página /consulta
        configureCorsForPage(registry, "/consulta/**");

        // Configuração específica para a página /exame_samgue
        configureCorsForPage(registry, "/exame_samgue/**");

        // Configuração específica para a página /exame_mri
        configureCorsForPage(registry, "/exame_mri/**");

        // Configuração específica para a página /plano_saude
        configureCorsForPage(registry, "/plano_saude/**");

        // Configuração específica para a página /endereco
        configureCorsForPage(registry, "/endereco/**");

        // Configuração específica para a página /especialidade
        configureCorsForPage(registry, "/especialidade/**");

        // Configuração específica para a página /prediagnostico
        configureCorsForPage(registry, "/prediagnostico/**");
    }

    private void configureCorsForPage(CorsRegistry registry, String page) {
        registry.addMapping(page)
                .allowedMethods("GET", "POST", "PUT", "DELETE");
    }
}

