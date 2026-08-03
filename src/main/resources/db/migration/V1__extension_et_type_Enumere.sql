-- Extension --
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Type enuméré --
CREATE TYPE role_enum AS ENUM ('STUDENT', 'GESTIONNAIRE', 'ADMIN');
CREATE TYPE type_ressource_enum AS ENUM ('COUR', 'NOTE', 'EPREUVE', 'TD');
CREATE TYPE statut_signalement_enum AS ENUM ('ATTENTE', 'TRAITE', 'REJETE');
CREATE TYPE type_paiement_enum AS ENUM ('ABONNEMENT', 'ACHAT_RESSOURCE');
CREATE TYPE statut_paiement_enum AS ENUM ('EN_ATTENTE', 'REUSSI', 'ECHOUE', 'REMBOURSE');
CREATE TYPE statut_souscription_enum AS ENUM ('ACTIF', 'EXPIRE', 'ANNULE');
