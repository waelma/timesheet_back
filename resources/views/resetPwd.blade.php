<!--Section: Block Content-->
<section class="mb-5 text-center">

    <p>Set a new password</p>

    <form action="{{route('entreprise.resetPwd',$detail['id'])}}" method="GET">
        @csrf

      <div class="md-form md-outline">
        <input type="password" name="pwd" id="newPass" class="form-control">
        <label data-error="wrong" data-success="right" for="newPass">New password</label>
      </div>

      <div class="md-form md-outline">
        <input type="password" name="c_pwd" id="newPassConfirm" class="form-control">
        <label data-error="wrong" data-success="right" for="newPassConfirm">Confirm password</label>
      </div>

      <button type="submit" class="btn btn-primary mb-4">Change password</button>

    </form>

    <div class="d-flex justify-content-between align-items-center mb-2">

      <u><a href="https://mdbootstrap.com/docs/jquery/admin/auth/login/">Back to Log In</a></u>

      <u><a href="https://mdbootstrap.com/docs/jquery/admin/auth/register/">Register</a></u>

    </div>

  </section>
  <!--Section: Block Content-->
