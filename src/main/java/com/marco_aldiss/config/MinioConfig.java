package com.marco_aldiss.config;

import io.minio.MinioClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class MinioConfig{
    @Value("${minio.url}")
    private String minioUrl;
    @Value("${minio.access-key}")
    private String cle_acces;
    @Value("${minio.secret-Key}")
    private String cle_secret;

    @Bean
    public MinioClient MinioClient(){
        return MinioClient.builder()
            .endpoint(minioUrl)
            .credentials(cle_acces, cle_secret)
            .build();
    }
}
