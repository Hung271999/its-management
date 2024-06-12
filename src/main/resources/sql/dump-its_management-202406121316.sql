PGDMP                         |            its_management    13.14    13.14 1    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    19111    its_management    DATABASE     r   CREATE DATABASE its_management WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE its_management;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3            �            1259    19357    its_role    TABLE     )  CREATE TABLE public.its_role (
    role_id bigint NOT NULL,
    description character varying(255),
    role_name character varying(20),
    CONSTRAINT its_role_role_name_check CHECK (((role_name)::text = ANY ((ARRAY['ROLE_USER'::character varying, 'ROLE_ADMIN'::character varying])::text[])))
);
    DROP TABLE public.its_role;
       public         heap    postgres    false    3            �            1259    19355    its_role_role_id_seq    SEQUENCE     }   CREATE SEQUENCE public.its_role_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.its_role_role_id_seq;
       public          postgres    false    201    3            �           0    0    its_role_role_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.its_role_role_id_seq OWNED BY public.its_role.role_id;
          public          postgres    false    200            �            1259    19366 
   its_system    TABLE     �   CREATE TABLE public.its_system (
    id bigint NOT NULL,
    created_date timestamp(6) without time zone,
    updated_date timestamp(6) without time zone,
    system_name character varying(255),
    created_by bigint,
    updated_by bigint
);
    DROP TABLE public.its_system;
       public         heap    postgres    false    3            �            1259    19364    its_system_id_seq    SEQUENCE     z   CREATE SEQUENCE public.its_system_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.its_system_id_seq;
       public          postgres    false    3    203            �           0    0    its_system_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.its_system_id_seq OWNED BY public.its_system.id;
          public          postgres    false    202            �            1259    19455    its_task    TABLE     �  CREATE TABLE public.its_task (
    id bigint NOT NULL,
    created_date timestamp(6) without time zone,
    updated_date timestamp(6) without time zone,
    content character varying(255),
    cost double precision,
    end_date timestamp(6) without time zone,
    expired_date timestamp(6) without time zone,
    note character varying(255),
    receive_date timestamp(6) without time zone,
    start_date timestamp(6) without time zone,
    status_id integer,
    ticket_number character varying(255),
    ticket_url character varying(255),
    type_id integer,
    created_by bigint,
    user_id bigint,
    system_id bigint,
    updated_by bigint
);
    DROP TABLE public.its_task;
       public         heap    postgres    false    3            �            1259    19453    its_task_id_seq    SEQUENCE     x   CREATE SEQUENCE public.its_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.its_task_id_seq;
       public          postgres    false    3    208            �           0    0    its_task_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.its_task_id_seq OWNED BY public.its_task.id;
          public          postgres    false    207            �            1259    19385    its_user    TABLE     �  CREATE TABLE public.its_user (
    id bigint NOT NULL,
    created_date timestamp(6) without time zone,
    updated_date timestamp(6) without time zone,
    email character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    password character varying(255),
    user_name character varying(255),
    created_by bigint,
    updated_by bigint
);
    DROP TABLE public.its_user;
       public         heap    postgres    false    3            �            1259    19383    its_user_id_seq    SEQUENCE     x   CREATE SEQUENCE public.its_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.its_user_id_seq;
       public          postgres    false    3    205            �           0    0    its_user_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.its_user_id_seq OWNED BY public.its_user.id;
          public          postgres    false    204            �            1259    19394    its_user_role    TABLE     `   CREATE TABLE public.its_user_role (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);
 !   DROP TABLE public.its_user_role;
       public         heap    postgres    false    3            :           2604    19360    its_role role_id    DEFAULT     t   ALTER TABLE ONLY public.its_role ALTER COLUMN role_id SET DEFAULT nextval('public.its_role_role_id_seq'::regclass);
 ?   ALTER TABLE public.its_role ALTER COLUMN role_id DROP DEFAULT;
       public          postgres    false    200    201    201            <           2604    19369    its_system id    DEFAULT     n   ALTER TABLE ONLY public.its_system ALTER COLUMN id SET DEFAULT nextval('public.its_system_id_seq'::regclass);
 <   ALTER TABLE public.its_system ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    202    203    203            >           2604    19458    its_task id    DEFAULT     j   ALTER TABLE ONLY public.its_task ALTER COLUMN id SET DEFAULT nextval('public.its_task_id_seq'::regclass);
 :   ALTER TABLE public.its_task ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    207    208    208            =           2604    19388    its_user id    DEFAULT     j   ALTER TABLE ONLY public.its_user ALTER COLUMN id SET DEFAULT nextval('public.its_user_id_seq'::regclass);
 :   ALTER TABLE public.its_user ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    204    205    205            �          0    19357    its_role 
   TABLE DATA           C   COPY public.its_role (role_id, description, role_name) FROM stdin;
    public          postgres    false    201   }=       �          0    19366 
   its_system 
   TABLE DATA           i   COPY public.its_system (id, created_date, updated_date, system_name, created_by, updated_by) FROM stdin;
    public          postgres    false    203   �=       �          0    19455    its_task 
   TABLE DATA           �   COPY public.its_task (id, created_date, updated_date, content, cost, end_date, expired_date, note, receive_date, start_date, status_id, ticket_number, ticket_url, type_id, created_by, user_id, system_id, updated_by) FROM stdin;
    public          postgres    false    208   �?       �          0    19385    its_user 
   TABLE DATA           �   COPY public.its_user (id, created_date, updated_date, email, first_name, last_name, password, user_name, created_by, updated_by) FROM stdin;
    public          postgres    false    205   [@       �          0    19394    its_user_role 
   TABLE DATA           9   COPY public.its_user_role (user_id, role_id) FROM stdin;
    public          postgres    false    206   �@       �           0    0    its_role_role_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.its_role_role_id_seq', 1, false);
          public          postgres    false    200            �           0    0    its_system_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.its_system_id_seq', 1, false);
          public          postgres    false    202            �           0    0    its_task_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.its_task_id_seq', 1, false);
          public          postgres    false    207            �           0    0    its_user_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.its_user_id_seq', 1, true);
          public          postgres    false    204            @           2606    19363    its_role its_role_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.its_role
    ADD CONSTRAINT its_role_pkey PRIMARY KEY (role_id);
 @   ALTER TABLE ONLY public.its_role DROP CONSTRAINT its_role_pkey;
       public            postgres    false    201            B           2606    19371    its_system its_system_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.its_system
    ADD CONSTRAINT its_system_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.its_system DROP CONSTRAINT its_system_pkey;
       public            postgres    false    203            L           2606    19463    its_task its_task_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.its_task
    ADD CONSTRAINT its_task_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.its_task DROP CONSTRAINT its_task_pkey;
       public            postgres    false    208            D           2606    19393    its_user its_user_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.its_user
    ADD CONSTRAINT its_user_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.its_user DROP CONSTRAINT its_user_pkey;
       public            postgres    false    205            J           2606    19398     its_user_role its_user_role_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.its_user_role
    ADD CONSTRAINT its_user_role_pkey PRIMARY KEY (user_id, role_id);
 J   ALTER TABLE ONLY public.its_user_role DROP CONSTRAINT its_user_role_pkey;
       public            postgres    false    206    206            F           2606    19400 %   its_user uk_bt4p87lylotr0m15eh7a2ku8a 
   CONSTRAINT     d   ALTER TABLE ONLY public.its_user
    ADD CONSTRAINT uk_bt4p87lylotr0m15eh7a2ku8a UNIQUE (password);
 O   ALTER TABLE ONLY public.its_user DROP CONSTRAINT uk_bt4p87lylotr0m15eh7a2ku8a;
       public            postgres    false    205            H           2606    19402 %   its_user uk_e6kmflvr4wy5wnt1fk8k0aaf6 
   CONSTRAINT     e   ALTER TABLE ONLY public.its_user
    ADD CONSTRAINT uk_e6kmflvr4wy5wnt1fk8k0aaf6 UNIQUE (user_name);
 O   ALTER TABLE ONLY public.its_user DROP CONSTRAINT uk_e6kmflvr4wy5wnt1fk8k0aaf6;
       public            postgres    false    205            P           2606    19438 $   its_user fk2n6jvh0fwsu84mqr28xmu0qpl    FK CONSTRAINT     �   ALTER TABLE ONLY public.its_user
    ADD CONSTRAINT fk2n6jvh0fwsu84mqr28xmu0qpl FOREIGN KEY (updated_by) REFERENCES public.its_user(id);
 N   ALTER TABLE ONLY public.its_user DROP CONSTRAINT fk2n6jvh0fwsu84mqr28xmu0qpl;
       public          postgres    false    205    2884    205            N           2606    19408 &   its_system fk33lc5qw9xft81gq59m30bnqs0    FK CONSTRAINT     �   ALTER TABLE ONLY public.its_system
    ADD CONSTRAINT fk33lc5qw9xft81gq59m30bnqs0 FOREIGN KEY (updated_by) REFERENCES public.its_user(id);
 P   ALTER TABLE ONLY public.its_system DROP CONSTRAINT fk33lc5qw9xft81gq59m30bnqs0;
       public          postgres    false    205    203    2884            Q           2606    19443 )   its_user_role fk5jbrf7bpmbufv3mcqiholbwno    FK CONSTRAINT     �   ALTER TABLE ONLY public.its_user_role
    ADD CONSTRAINT fk5jbrf7bpmbufv3mcqiholbwno FOREIGN KEY (role_id) REFERENCES public.its_role(role_id);
 S   ALTER TABLE ONLY public.its_user_role DROP CONSTRAINT fk5jbrf7bpmbufv3mcqiholbwno;
       public          postgres    false    201    206    2880            V           2606    19479 $   its_task fk7ae6s18a955tsyruyb9fn7dp6    FK CONSTRAINT     �   ALTER TABLE ONLY public.its_task
    ADD CONSTRAINT fk7ae6s18a955tsyruyb9fn7dp6 FOREIGN KEY (updated_by) REFERENCES public.its_user(id);
 N   ALTER TABLE ONLY public.its_task DROP CONSTRAINT fk7ae6s18a955tsyruyb9fn7dp6;
       public          postgres    false    208    205    2884            U           2606    19474 $   its_task fk8muv0e1vp4d9xbd8i7o8x17dh    FK CONSTRAINT     �   ALTER TABLE ONLY public.its_task
    ADD CONSTRAINT fk8muv0e1vp4d9xbd8i7o8x17dh FOREIGN KEY (system_id) REFERENCES public.its_system(id);
 N   ALTER TABLE ONLY public.its_task DROP CONSTRAINT fk8muv0e1vp4d9xbd8i7o8x17dh;
       public          postgres    false    203    2882    208            O           2606    19433 $   its_user fken6q8bif21qfsus5jbn6vnja3    FK CONSTRAINT     �   ALTER TABLE ONLY public.its_user
    ADD CONSTRAINT fken6q8bif21qfsus5jbn6vnja3 FOREIGN KEY (created_by) REFERENCES public.its_user(id);
 N   ALTER TABLE ONLY public.its_user DROP CONSTRAINT fken6q8bif21qfsus5jbn6vnja3;
       public          postgres    false    2884    205    205            S           2606    19464 $   its_task fkib7ly9dms2hysroo2xc0smbum    FK CONSTRAINT     �   ALTER TABLE ONLY public.its_task
    ADD CONSTRAINT fkib7ly9dms2hysroo2xc0smbum FOREIGN KEY (created_by) REFERENCES public.its_user(id);
 N   ALTER TABLE ONLY public.its_task DROP CONSTRAINT fkib7ly9dms2hysroo2xc0smbum;
       public          postgres    false    208    205    2884            R           2606    19448 )   its_user_role fkmne2dmadqhp2b0fip2bjhwqr2    FK CONSTRAINT     �   ALTER TABLE ONLY public.its_user_role
    ADD CONSTRAINT fkmne2dmadqhp2b0fip2bjhwqr2 FOREIGN KEY (user_id) REFERENCES public.its_user(id);
 S   ALTER TABLE ONLY public.its_user_role DROP CONSTRAINT fkmne2dmadqhp2b0fip2bjhwqr2;
       public          postgres    false    205    2884    206            T           2606    19469 $   its_task fko4ftqx65unbaj5yrkpy5lfo43    FK CONSTRAINT     �   ALTER TABLE ONLY public.its_task
    ADD CONSTRAINT fko4ftqx65unbaj5yrkpy5lfo43 FOREIGN KEY (user_id) REFERENCES public.its_user(id);
 N   ALTER TABLE ONLY public.its_task DROP CONSTRAINT fko4ftqx65unbaj5yrkpy5lfo43;
       public          postgres    false    2884    208    205            M           2606    19403 &   its_system fkrw7rk8gqh43t2ka0gcy0tvqft    FK CONSTRAINT     �   ALTER TABLE ONLY public.its_system
    ADD CONSTRAINT fkrw7rk8gqh43t2ka0gcy0tvqft FOREIGN KEY (created_by) REFERENCES public.its_user(id);
 P   ALTER TABLE ONLY public.its_system DROP CONSTRAINT fkrw7rk8gqh43t2ka0gcy0tvqft;
       public          postgres    false    205    203    2884            �   9   x�3�tL����,.)J,�/R(��I���q�wt����2�-NEv����� A��      �   �  x���OKA���)�(�j��i�n$,�ѥK��PAy�3��AJb�2J�İ��2���E�]W�E�%^Y�����;ϼ#O)n��t{��(>���]��������gc[����P��^�	���G�if��_�Y4XX�,<}�
,��f�ό��s�uf4��MYO�V6���4���{��P2��F�N����\������F	Y$2V�j�����L�=t�=��瀽KJ?!���m�m�c�;�����'Yi��F�m�3"��h�yA�U�kH#���%]�D��r�`�<;����
�I��u``��ܴ���	�l�V�^HjP47����⏕
�J��@���@��wR���a����-����w�<O���H�P��rHZ(b�u�	���W��U�~��ו,�D�kH�F���$���t��|L�7�8|����.���%���      �   �   x��ӱ!@����l�x�4��Q���.&�E���ꉑ[A-��!#�M}��J�hv,H��`2��ڦ~�.�j$��Z�F�s���L�(������JU��8xF9�?ԫ�l�^�;��c�z |u�ݷ�P���=�����Vh������� ��W�iJ      �   H   x�3�4202�50�54R00�21�22�3�4776�'�����琞��������#��F�&P~�q��qqq �~�      �      x�3�4����� ]     