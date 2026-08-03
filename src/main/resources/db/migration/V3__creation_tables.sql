-- Creation des tables --

CREATE TABLE filieres (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(20) NOT NULL UNIQUE,
    nom VARCHAR(20) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE niveaux (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(20) NOT NULL UNIQUE,
    nom VARCHAR(50) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    keycloak_id VARCHAR(255) NOT NULL,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    role role_enum NOT NULL DEFAULT 'STUDENT',
    niveau_id UUID REFERENCES niveaux(id) ON DELETE SET NULL,
    filieres UUID REFERENCES filieres(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE matieres (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(20) NOT NULL UNIQUE,
    nom VARCHAR(150) NOT NULL,
    description TEXT,
    filiere_id UUID REFERENCES filieres(id) ON DELETE CASCADE,
    niveau_id UUID REFERENCES niveaux(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ressources (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    titre VARCHAR(255) NOT NULL,
    description TEXT,
    type_ressource type_ressource_enum NOT NULL,
    fichier_url TEXT NOT NULL, -- Stocké dans MinIO
    matiere_id UUID REFERENCES matieres(id) ON DELETE CASCADE,
    nom_auteur VARCHAR(100),
    est_payante BOOLEAN NOT NULL DEFAULT TRUE,
    prix NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    telechargements_count INT DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE favoris (
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    ressource_id UUID REFERENCES ressources(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, ressource_id)
);

CREATE TABLE signalement (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    ressource_id UUID REFERENCES ressources(id) ON DELETE CASCADE,
    signaleur_id UUID REFERENCES users(id) ON DELETE CASCADE,
    motif TEXT NOT NULL,
    statut statut_signalement_enum NOT NULL DEFAULT 'ATTENTE',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE plans_abonnement (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(50) NOT NULL UNIQUE,
    nom VARCHAR(50) NOT NULL,
    description TEXT,
    prix_mensuel NUMERIC(10, 2) NOT NULL,
    duree_jours INT NOT NULL DEFAULT 30,
    actif BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Déplacée AVANT souscription pour satisfaire la clé étrangère
CREATE TABLE transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    reference_transact VARCHAR(100) NOT NULL UNIQUE,
    montant NUMERIC(10, 2) NOT NULL,
    type_paiement type_paiement_enum NOT NULL,
    statut statut_paiement_enum NOT NULL DEFAULT 'EN_ATTENTE',
    mode_paiement VARCHAR(50),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE souscription (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_user UUID REFERENCES users(id) ON DELETE CASCADE,
    plan_id UUID REFERENCES plans_abonnement(id),
    date_debut TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_fin TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    statut statut_souscription_enum NOT NULL DEFAULT 'EXPIRE',
    transaction_id UUID REFERENCES transactions(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE achats_ressources (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    ressource_id UUID NOT NULL REFERENCES ressources(id) ON DELETE CASCADE,
    transaction_id UUID NOT NULL REFERENCES transactions(id) ON DELETE CASCADE,
    prix_paye NUMERIC(10, 2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, ressource_id)
);
