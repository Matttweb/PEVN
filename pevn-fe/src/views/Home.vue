<template>
  <v-container>
    <v-app-bar app color="primary" dark>
      <v-toolbar-title>Mattweb</v-toolbar-title>
    </v-app-bar>
    <v-alert text v-model="alert.show" :type="alert.type" dismissible>{{alert.message}}</v-alert>
    <v-row justify="center">
      <v-col class="text-center" md="2" sm="2">
        <v-btn class="primary"  @click="suForm=true">sign up</v-btn>
      </v-col>
      <v-col class="text-center" md="2" sm="2">
        <v-btn class="success"  @click="suForm=false">sign in</v-btn>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col md="6" sm="6">
        <v-card v-if="suForm">
          <v-card-title>Sign Up</v-card-title>
          <v-card-text>
            <v-form class="ma-3" @submit.prevent="signup()" ref="signupForm">
              <v-text-field
                label="Name"
                prepend-icon="mdi-account"
                :rules="nameRules"
                v-model="user.name"
              ></v-text-field>
              <v-text-field
                label="E-mail"
                prepend-icon="mdi-email"
                :rules="emailRules"
                v-model="user.email"
              ></v-text-field>
              <v-text-field
                label="Password"
                prepend-icon="mdi-lock"
                type="password"
                :rules="passwordRules"
                v-model="user.password"
              ></v-text-field>
              <v-radio-group row v-model="user.role" :rules="[(v) => !!v || 'Please choose one']">
                <v-radio label="Professor" value="professor"></v-radio>
                <v-radio label="Student" value="student"></v-radio>
              </v-radio-group>
              <v-btn block class="primary mt-3" type="submit">sign up</v-btn>
            </v-form>
          </v-card-text>
        </v-card>
        <v-card v-else>
          <v-card-title>Sign In</v-card-title>
          <v-card-text>
            <v-form class="ma-3" @submit.prevent="signin()" ref="signinForm">
              <v-text-field
                label="E-mail"
                prepend-icon="mdi-email"
                :rules="emailRules"
                v-model="user.email"
              ></v-text-field>
              <v-text-field
                label="Password"
                prepend-icon="mdi-lock"
                type="password"
                :rules="passwordRules"
                v-model="user.password"
              ></v-text-field>
              <v-radio-group row v-model="user.role" :rules="[(v) => !!v || 'Please choose one']">
                <v-radio label="Professor" value="professor"></v-radio>
                <v-radio label="Student" value="student"></v-radio>
              </v-radio-group>
              <v-btn block class="success mt-3" type="submit">sign in</v-btn>
            </v-form>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data: () => ({
    alert: { show: false, message: "" },
    nameRules: [
      value => !!value || "Name is required",
      value =>
        (value && value.length >= 5) || "Name must be more than 5 characters"
    ],
    emailRules: [
      value => !!value || "E-mail is required",
      value => /.+@.+\..+/.test(value) || "E-mail must be valid"
    ],
    passwordRules: [
      value => !!value || "Password is required",
      value =>
        (value && value.length >= 2) ||
        "Password must be more than 2 characters"
    ],
    user: { name: "", email: "", password: "", role: "" },
    suForm: true
  }),
  methods: {
    async signup() {
      let valid = this.$refs.signupForm.validate();
      if (valid) {
        try {
          const res = await this.axios.post("/signup", this.user);
          this.$refs.signupForm.reset();
          this.suForm = false;
          this.alert = {
            show: true,
            type: "success",
            message: res.data.message
          };
        } catch (error) {
          this.alert = {
            show: true,
            type: "error",
            message: error.response.data.message
          };
        }
      }
    },
    async signin() {
      let valid = this.$refs.signinForm.validate();
      if (valid) {
        try {
          const res = await this.axios.post("/signin", this.user);
          if (res.data.NotFound) {
            this.alert = {
              show: true,
              type: "error",
              message: res.data.message
            };
          } else {
            sessionStorage.setItem("session", JSON.stringify(res.data));
            this.$router.push('/profile')
          }
        } catch (error) {
          this.alert = {
            show: true,
            type: "error",
            message: error.response.data.message
          };
        }
      }
    }
  }
};
</script>
